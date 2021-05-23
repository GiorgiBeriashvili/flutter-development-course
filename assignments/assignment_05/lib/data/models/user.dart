import 'dart:convert';

import 'package:assignment_05/data/models/address.dart';
import 'package:assignment_05/data/models/company.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String userName;
  final String email;
  final Address address;
  final String phone;
  final String website;
  final Company company;

  const User({
    required this.id,
    required this.name,
    required this.userName,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  @override
  List<Object> get props => [
        id,
        name,
        userName,
        email,
        address,
        phone,
        website,
        company,
      ];

  User copyWith({
    int? id,
    String? name,
    String? userName,
    String? email,
    Address? address,
    String? phone,
    String? website,
    Company? company,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        userName: userName ?? this.userName,
        email: email ?? this.email,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        website: website ?? this.website,
        company: company ?? this.company,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'username': userName,
        'email': email,
        'address': address.toMap(),
        'phone': phone,
        'website': website,
        'company': company.toMap(),
      };

  factory User.fromMap(Map<String, dynamic> map) => User(
        id: map['id'],
        name: map['name'],
        userName: map['username'],
        email: map['email'],
        address: Address.fromMap(map['address']),
        phone: map['phone'],
        website: map['website'],
        company: Company.fromMap(map['company']),
      );

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(
        json.decode(source),
      );

  @override
  String toString() =>
      'User(id: $id, name: $name, userName: $userName, email: $email, address: $address, phone: $phone, website: $website, company: $company)';
}
