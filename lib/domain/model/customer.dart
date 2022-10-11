import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  final String id;
  final String name;
  final String email;
  final bool isActive;

  const Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.isActive,
  });

  @override
  List<Object> get props {
    return [id, name, email, isActive];
  }
}
