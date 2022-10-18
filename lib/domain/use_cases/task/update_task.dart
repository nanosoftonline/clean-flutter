import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:crm/domain/model/task.dart';
import 'package:crm/domain/repositories/interfaces/task_repository.dart';
import 'package:dartz/dartz.dart';

abstract class UpdateTask {
  Future<Either<Failure, Unit>> execute(
    String id, {
    Customer? customer,
    Priority? priority,
    String? subject,
    Status? status,
    DateTime? dueDate,
  });
}

class UpdateTaskImpl implements UpdateTask {
  TaskRepository taskRepository;
  UpdateTaskImpl(this.taskRepository);

  @override
  Future<Either<Failure, Unit>> execute(
    String id, {
    Customer? customer,
    Priority? priority,
    String? subject,
    Status? status,
    DateTime? dueDate,
  }) async {
    final result = await taskRepository.updateTask(
      id,
      customer: customer,
      priority: priority,
      dueDate: dueDate,
      status: status,
      subject: subject,
    );
    return result;
  }
}
