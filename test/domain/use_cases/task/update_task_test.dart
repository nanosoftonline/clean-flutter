import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/task.dart';
import 'package:crm/domain/repositories/interfaces/task_repository.dart';
import 'package:crm/domain/use_cases/task/update_task.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late TaskRepository mockTaskRepository;
  late UpdateTask usecase;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    usecase = UpdateTaskImpl(mockTaskRepository);
  });

  test("should call the updateTask with data to be updated", () async {
    //arrange
    const id = "1001";
    Either<Failure, Unit> repoResponse = const Right(unit);
    when(() => mockTaskRepository.updateTask(id, priority: Priority.high))
        .thenAnswer((realInvocation) async => repoResponse);

    //act
    final result = await usecase.execute(id, priority: Priority.high);

    //assert
    expect(result, equals(repoResponse));
    verify(() => mockTaskRepository.updateTask(id, priority: Priority.high));
    verifyNoMoreInteractions(mockTaskRepository);
  });
}
