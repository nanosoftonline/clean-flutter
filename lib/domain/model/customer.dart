import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum CustomerType {
  lead,
  customer,
}

@immutable
class Customer extends Equatable {
  final String? id;
  final String name;
  final String email;
  final CustomerType customerType;
  final bool isActive;

  const Customer({
    this.id,
    required this.name,
    required this.email,
    this.isActive = true,
    this.customerType = CustomerType.customer,
  });

  dynamic toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'isActive': isActive,
        "customerType": customerType,
      };

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  List<Object> get props {
    return [name, email, isActive, customerType];
  }
}
