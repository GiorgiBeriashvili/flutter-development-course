import 'dart:async';

import 'package:midterm_02/core/exceptions.dart';
import 'package:midterm_02/data/models/models.dart';
import 'package:midterm_02/data/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part '../events/transaction_event.dart';
part '../states/transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository transactionRepository;

  StreamSubscription<List<Transaction>>? _transactionSubscription;

  TransactionBloc({
    required this.transactionRepository,
  }) : super(TransactionInitial());

  @override
  Stream<TransactionState> mapEventToState(
    TransactionEvent event,
  ) async* {
    if (event is TransactionCreated) {
      yield* _mapTransactionCreatedToState(event);
    } else if (event is TransactionDeleted) {
      yield* _mapTransactionDeletedToState(event);
    } else if (event is TransactionStarted) {
      yield* _mapTransactionStartedToState();
    } else if (event is TransactionUpdated) {
      yield* _mapTransactionUpdatedToState(event);
    } else if (event is TransactionUpdatedAll) {
      yield* _mapTransactionUpdatedAllToState(event);
    }
  }

  Stream<TransactionState> _mapTransactionCreatedToState(
    TransactionCreated event,
  ) async* {
    yield TransactionLoadInProgress();

    try {
      await transactionRepository.create(
        Transaction.fromJson(event.transaction),
      );
    } on TransactionException catch (exception) {
      yield TransactionLoadFailure(exception: exception);
    }
  }

  Stream<TransactionState> _mapTransactionDeletedToState(
    TransactionDeleted event,
  ) async* {
    yield TransactionLoadInProgress();

    try {
      await transactionRepository.delete(event.transaction);
    } on TransactionException catch (exception) {
      yield TransactionLoadFailure(exception: exception);
    }
  }

  Stream<TransactionState> _mapTransactionStartedToState() async* {
    yield TransactionLoadInProgress();

    try {
      _transactionSubscription?.cancel();

      _transactionSubscription = transactionRepository.readAll().listen(
            (transactions) => add(
              TransactionUpdatedAll(transactions: transactions),
            ),
          );
    } on Exception catch (exception) {
      yield TransactionLoadFailure(exception: TransactionException(exception));
    }
  }

  Stream<TransactionState> _mapTransactionUpdatedToState(
    TransactionUpdated event,
  ) async* {
    yield TransactionLoadInProgress();

    try {
      await transactionRepository.update(event.transaction);
    } on TransactionException catch (exception) {
      yield TransactionLoadFailure(exception: exception);
    }
  }

  Stream<TransactionState> _mapTransactionUpdatedAllToState(
    TransactionUpdatedAll event,
  ) async* {
    yield TransactionLoadInProgress();

    try {
      yield TransactionLoadSuccess(transactions: event.transactions);
    } on TransactionException catch (exception) {
      yield TransactionLoadFailure(exception: exception);
    }
  }

  @override
  Future<void> close() {
    _transactionSubscription?.cancel();

    return super.close();
  }
}
