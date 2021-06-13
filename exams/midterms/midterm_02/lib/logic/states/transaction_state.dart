part of '../blocs/transaction_bloc.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {
  @override
  String toString() => 'TransactionInitial {}';
}

class TransactionLoadInProgress extends TransactionState {
  @override
  String toString() => 'TransactionLoadInProgress {}';
}

class TransactionLoadSuccess extends TransactionState {
  final List<Transaction> transactions;

  const TransactionLoadSuccess({required this.transactions});

  @override
  List<Object> get props => [transactions];

  @override
  String toString() => 'TransactionLoadSuccess { transactions: $transactions }';
}

class TransactionLoadFailure extends TransactionState {
  final TransactionException exception;

  const TransactionLoadFailure({required this.exception});

  @override
  List<Object> get props => [exception];

  @override
  String toString() => 'TransactionLoadFailure { exception: $exception }';
}

class TransactionDeletedSuccess extends TransactionState {
  final String message;

  const TransactionDeletedSuccess({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'TransactionLoadSuccess { message: $message }';
}
