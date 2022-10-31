import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/repositories/interfaces/task_repository.dart';
import 'package:crm/domain/use_cases/task/delete_task.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late TaskRepository mockTaskRepository;
  late DeleteTask usecase;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    usecase = DeleteTaskImpl(mockTaskRepository);
  });

  test("should call the deleteTask method of task repo", () async {
    //arrange
    const id = "1001";
    Either<Failure, Unit> repoResponse = const Right(unit);
    when(() => mockTaskRepository.deleteTask(id)).thenAnswer((realInvocation) async => repoResponse);

    //act
    final result = await usecase.execute(id);

    //assert
    expect(result, equals(repoResponse));
    verify(() => mockTaskRepository.deleteTask(id));
    verifyNoMoreInteractions(mockTaskRepository);
  });
}
