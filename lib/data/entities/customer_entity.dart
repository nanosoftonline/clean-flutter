import 'package:crm/domain/model/customer.dart';
import 'package:equatable/equatable.dart';

class CustomerEntity extends Equatable {
  final String id;
  final String customerName;
  final String emailAddress;
  final CustomerType type;
  final bool active;

  const CustomerEntity({
    required this.id,
    required this.customerName,
    required this.emailAddress,
    this.active = true,
    this.type = CustomerType.customer,
  });

  @override
  List<Object> get props {
    return [id, customerName, emailAddress, active, type];
  }
}
