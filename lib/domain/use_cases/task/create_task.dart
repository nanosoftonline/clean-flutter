import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/task.dart';
import 'package:crm/domain/repositories/interfaces/task_repository.dart';
import 'package:dartz/dartz.dart';

abstract class CreateTask {
  Future<Either<Failure, Unit>> execute(CRMTask task);
}

class CreateTaskImpl implements CreateTask {
  TaskRepository taskRepository;
  CreateTaskImpl(this.taskRepository);

  @override
  Future<Either<Failure, Unit>> execute(CRMTask task) async {
    final result = await taskRepository.createTask(task);
    return result;
  }
}
