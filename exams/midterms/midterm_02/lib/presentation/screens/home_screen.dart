import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:midterm_02/core/constants.dart' as constants;
import 'package:midterm_02/data/models/models.dart';
import 'package:midterm_02/data/repositories/repositories.dart';
import 'package:midterm_02/logic/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midterm_02/presentation/screens/transaction/transaction_screens.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/transactions';

  final int userId;

  const HomeScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => TransactionBloc(
          transactionRepository: TransactionRepository(
            userId: userId,
            dio: Dio(),
          ),
        )..add(TransactionStarted()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(constants.appTitle),
          ),
          body: BlocConsumer<TransactionBloc, TransactionState>(
            listener: (context, state) {
              if (state is TransactionLoadFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.exception.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is TransactionLoadInProgress) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TransactionLoadSuccess) {
                return ListView.separated(
                  itemCount: state.transactions.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final transaction = state.transactions[index];

                    return Dismissible(
                      key: Key(transaction.id.toString()),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColorLight,
                          child: const Icon(Icons.attach_money),
                        ),
                        title: Text(transaction.title),
                        isThreeLine: true,
                        subtitle: Text(
                          '${transaction.amount}\n${DateFormat.Hms().format(
                            DateTime.parse(transaction.dateTime),
                          )}, ${DateFormat.yMMMMd().format(
                            DateTime.parse(transaction.dateTime),
                          )}',
                        ),
                        onTap: () => showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          builder: (context) => SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 24),
                              child: ListView(
                                children: [
                                  Text(
                                    'Description',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.subtitle1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      transaction.description,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        onLongPress: () => Navigator.of(context)
                            .pushNamed(
                          EditTransactionScreen.routeName,
                          arguments: transaction,
                        )
                            .then(
                          (transaction) async {
                            if (transaction != null) {
                              context.read<TransactionBloc>().add(
                                    TransactionUpdated(
                                      transaction: transaction as Transaction,
                                    ),
                                  );
                            }
                          },
                        ),
                      ),
                      onDismissed: (direction) => context
                          .read<TransactionBloc>()
                          .add(TransactionDeleted(transaction: transaction)),
                      confirmDismiss: (direction) => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Remove the transaction'),
                          content: const Text(
                            'Would you like to remove the transaction?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Confirm'),
                            ),
                          ],
                        ),
                      ),
                      background: Container(
                        color: Theme.of(context).errorColor,
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: ElevatedButton.icon(
                    onPressed: () => context
                        .read<TransactionBloc>()
                        .add(TransactionStarted()),
                    icon: const Icon(Icons.replay),
                    label: const Text('Retry'),
                  ),
                );
              }
            },
          ),
          floatingActionButton: BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, state) {
              if (state is TransactionLoadSuccess) {
                return FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () => Navigator.of(context)
                      .pushNamed(AddTransactionScreen.routeName)
                      .then(
                    (transaction) async {
                      if (transaction != null) {
                        context.read<TransactionBloc>().add(
                              TransactionCreated(
                                transaction: transaction as Map<String, Object>,
                              ),
                            );
                      }
                    },
                  ),
                );
              }

              return const FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: null,
                backgroundColor: Colors.grey,
              );
            },
          ),
        ),
      );
}
