import 'package:crm/domain/model/customer.dart';
import 'package:equatable/equatable.dart';

enum Status { notStarted, deferred, inProgress, completed, waitingForInput }

enum Priority { low, normal, high }

class CRMTask extends Equatable {
  final String id;
  final Customer customer;
  final Priority priority;
  final String subject;
  final Status status;
  final DateTime dueDate;

  const CRMTask({
    required this.id,
    required this.customer,
    this.priority = Priority.high,
    this.status = Status.notStarted,
    required this.subject,
    required this.dueDate,
  });
  @override
  List<Object> get props {
    return [id, customer, priority, subject, dueDate];
  }
}
