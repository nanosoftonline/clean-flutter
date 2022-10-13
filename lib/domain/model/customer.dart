import 'package:equatable/equatable.dart';

enum CustomerType {
  lead,
  customer,
}

class Customer extends Equatable {
  final String id;
  final String name;
  final String email;
  final CustomerType customerType;
  final bool isActive;

  const Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.isActive,
    required this.customerType,
  });

  @override
  List<Object> get props {
    return [id, name, email, isActive, customerType];
  }
}
