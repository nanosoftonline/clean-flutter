import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/repositories/interfaces/task_repository.dart';
import 'package:crm/domain/use_cases/task/delete_customer_task.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delete_customer_task_test.mocks.dart';

@GenerateMocks([TaskRepository])
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
    when(mockTaskRepository.deleteTask(id)).thenAnswer((realInvocation) async => repoResponse);

    //act
    final result = await usecase.execute(id);

    //assert
    expect(result, equals(repoResponse));
    verify(mockTaskRepository.deleteTask(id));
    verifyNoMoreInteractions(mockTaskRepository);
  });
}
