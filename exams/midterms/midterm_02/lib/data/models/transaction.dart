import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final String id;
  final String title;
  final double amount;
  final String description;
  final String dateTime;

  const Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.description,
    required this.dateTime,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        amount,
        description,
        dateTime,
      ];

  factory Transaction.fromJson(Map<String, Object?> json) => Transaction(
        id: json['id'] as String,
        title: json['title'] as String,
        amount: json['amount'] as double,
        description: json['description'] as String,
        dateTime: json['datetime'] as String,
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'title': title,
        'amount': amount,
        'description': description,
        'datetime': dateTime,
      };

  @override
  String toString() => 'Transaction { '
      'id: $id, '
      'title: $title, '
      'amount: $amount, '
      'description: $description '
      'dateTime: $dateTime '
      '}';
}
