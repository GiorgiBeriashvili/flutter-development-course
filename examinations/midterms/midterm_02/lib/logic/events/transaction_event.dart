part of '../blocs/transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class TransactionCreated extends TransactionEvent {
  final Map<String, Object?> transaction;

  const TransactionCreated({required this.transaction});

  @override
  String toString() => 'TransactionCreated { transaction: $transaction }';
}

class TransactionDeleted extends TransactionEvent {
  final Transaction transaction;

  const TransactionDeleted({required this.transaction});

  @override
  String toString() => 'TransactionDeleted { transaction: $transaction }';
}

class TransactionStarted extends TransactionEvent {
  @override
  String toString() => 'TransactionStarted {}';
}

class TransactionUpdated extends TransactionEvent {
  final Transaction transaction;

  const TransactionUpdated({required this.transaction});

  @override
  String toString() => 'TransactionUpdated { transaction: $transaction }';
}

class TransactionUpdatedAll extends TransactionEvent {
  final List<Transaction> transactions;

  const TransactionUpdatedAll({required this.transactions});

  @override
  String toString() => 'TransactionUpdatedAll { transactions: $transactions }';
}
