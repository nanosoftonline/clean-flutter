import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:crm/domain/model/task.dart';
import 'package:crm/domain/repositories/interfaces/task_repository.dart';
import 'package:crm/domain/use_cases/task/create_task.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'create_task_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  late TaskRepository mockTaskRepository;
  late CreateTask usecase;
  setUp(() {
    mockTaskRepository = MockTaskRepository();
    usecase = CreateTaskImpl(mockTaskRepository);
  });

  test("should call createTask of task repo", () async {
    //arrange
    var customer = const Customer(id: "123", name: "Person", email: "person@email.com");
    var task = CRMTask(
      id: "1",
      customer: customer,
      subject: "Introduction meeting with customer",
      dueDate: DateTime.now(),
    );
    Either<Failure, Unit> repoResponse = const Right(unit);
    when(mockTaskRepository.createTask(task)).thenAnswer((realInvocation) async => repoResponse);

    //act
    final result = await usecase.execute(task);

    //assert
    expect(result, equals(repoResponse));
    verify(mockTaskRepository.createTask(task));
    verifyNoMoreInteractions(mockTaskRepository);
  });
}
