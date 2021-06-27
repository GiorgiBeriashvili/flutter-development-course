import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:dio/dio.dart';
import 'package:midterm_02/core/exceptions.dart';
import 'package:midterm_02/data/models/models.dart';

class TransactionRepository {
  late final int userId;
  late final Dio dio;

  late final firestore.CollectionReference<Transaction> transactions;

  TransactionRepository({
    required this.userId,
    required this.dio,
  }) : transactions = firestore.FirebaseFirestore.instance
            .collection('users')
            .doc('$userId')
            .collection('transactions')
            .withConverter<Transaction>(
              fromFirestore: (snapshot, options) => Transaction.fromJson(
                snapshot.data()!,
              ),
              toFirestore: (transaction, options) => transaction.toJson(),
            );

  Future<void> delete(Transaction transaction) async => await transactions
      .doc(transaction.id)
      .delete()
      .catchError((error) => throw TransactionException(error));

  Future<void> create(Transaction transaction) async => await transactions
      .doc(transaction.id)
      .set(transaction)
      .catchError((error) => throw TransactionException(error));

  Stream<List<Transaction>> readAll() => transactions
      .orderBy(
        'datetime',
        descending: true,
      )
      .snapshots()
      .map(
        (snapshot) => snapshot.docs.map((document) => document.data()).toList(),
      );

  Future<void> update(Transaction transaction) async => await transactions
      .doc(transaction.id)
      .update(transaction.toJson())
      .catchError((error) => throw TransactionException(error));
}
