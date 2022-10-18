import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/repositories/interfaces/task_repository.dart';
import 'package:dartz/dartz.dart';

abstract class DeleteTask {
  Future<Either<Failure, Unit>> execute(String id);
}

class DeleteTaskImpl implements DeleteTask {
  TaskRepository taskRepository;
  DeleteTaskImpl(this.taskRepository);

  @override
  Future<Either<Failure, Unit>> execute(String id) async {
    final result = await taskRepository.deleteTask(id);
    return result;
  }
}
