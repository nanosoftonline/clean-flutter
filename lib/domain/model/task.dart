import 'package:crm/domain/model/customer.dart';

enum Status { notStarted, deferred, inProgress, completed, waitingForInput }

enum Priority { low, normal, high }

class Task {
  final String id;
  final Customer customer;
  final Priority priority;
  final String subject;
  final Status status;
  final DateTime dueDate;

  const Task({
    required this.id,
    required this.customer,
    this.priority = Priority.high,
    this.status = Status.notStarted,
    required this.subject,
    required this.dueDate,
  });
}
