import 'package:crm/domain/model/customer.dart';
import 'package:crm/domain/model/task.dart';
import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final String id;
  final Customer customer;
  final Priority priority;
  final String subject;
  final Status status;
  final DateTime dueDate;

  const TaskEntity({
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
