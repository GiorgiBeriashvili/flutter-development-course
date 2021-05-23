import 'package:assignment_05/core/constants.dart' as constants;
import 'package:assignment_05/logic/blocs/blocs.dart';
import 'package:assignment_05/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(constants.appTitle),
        ),
        body: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserLoadFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.exception.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is UserLoadInProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UserLoadSuccess) {
              return ListView.separated(
                itemCount: state.users.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final user = state.users[index];

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColorLight,
                      child: const Icon(Icons.person),
                    ),
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        PostsScreen.routeName,
                        arguments: user.id,
                      );

                      context
                          .read<PostBloc>()
                          .add(PostStarted(userId: user.id));
                    },
                  );
                },
              );
            } else {
              return Center(
                child: ElevatedButton.icon(
                  onPressed: () => context.read<UserBloc>().add(UserStarted()),
                  icon: const Icon(Icons.replay),
                  label: const Text('Retry'),
                ),
              );
            }
          },
        ),
      );
}
