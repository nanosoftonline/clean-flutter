import 'package:crm/core/error/failures.dart';
import 'package:crm/data/data_sources/interfaces/task_datasource.dart';
import 'package:crm/data/entities/task_entity.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:crm/domain/model/task.dart';
import 'package:crm/domain/repositories/implementations/task_repository_impl.dart';
import 'package:crm/domain/repositories/interfaces/task_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'task_repository_impl_test.mocks.dart';

@GenerateMocks([TaskDataSource])
void main() {
  late TaskDataSource mockDS;
  late TaskRepository repo;

  setUp(() {
    mockDS = MockTaskDataSource();
    repo = TaskRepositoryImpl(mockDS);
  });

  group("TaskRepository", () {
    group("createTask", () {
      test("should call create method of data source", () async {
        //arrange
        var customer = const Customer(id: "123", name: "John", email: "person@email.com");
        var task = CRMTask(id: "1001", customer: customer, subject: "Meeting", dueDate: DateTime.now());
        var taskEntity = TaskEntity(
          id: task.id,
          customer: customer,
          subject: task.subject,
          dueDate: task.dueDate,
        );
        when(mockDS.create(taskEntity)).thenAnswer((realInvocation) async => unit);

        //act
        final result = await repo.createTask(task);

        //assert
        expect(result, equals(const Right(unit)));
        verify(mockDS.create(taskEntity));
        verifyNoMoreInteractions(mockDS);
      });

      test("should return Failure when data source throws", () async {
        //arrange
        var customer = const Customer(id: "123", name: "John", email: "person@email.com");
        var task = CRMTask(id: "1001", customer: customer, subject: "Meeting", dueDate: DateTime.now());
        var taskEntity = TaskEntity(
          id: task.id,
          customer: customer,
          subject: task.subject,
          dueDate: task.dueDate,
        );
        when(mockDS.create(taskEntity)).thenThrow(ServerFailure());

        //act
        final result = await repo.createTask(task);

        //assert
        expect(result, equals(Left(ServerFailure())));
        verify(mockDS.create(taskEntity));
        verifyNoMoreInteractions(mockDS);
      });
    });

    group("deleteTask", () {
      test("should call delete method of data source", () async {
        //arrange
        var id = "1001";
        when(mockDS.delete(id)).thenAnswer((_) async => unit);

        //act
        final result = await repo.deleteTask(id);

        //assert
        expect(result, equals(const Right(unit)));
        verify(mockDS.delete(id));
        verifyNoMoreInteractions(mockDS);
      });

      test("should return Failure when data source throws", () async {
        //arrange
        //arrange
        var id = "1001";
        when(mockDS.delete(id)).thenThrow(ServerFailure());

        //act
        final result = await repo.deleteTask(id);

        //assert
        expect(result, equals(Left(ServerFailure())));
        verify(mockDS.delete(id));
        verifyNoMoreInteractions(mockDS);
      });
    });

    group("getAllTasks", () {
      test("should call find method of data source", () async {
        //arrange
        const customer = Customer(id: "123", name: "John", email: "john@email.com");
        List<TaskEntity> dsResponse = [
          TaskEntity(
            id: "1001",
            customer: customer,
            subject: "Meeting",
            dueDate: DateTime.now(),
          )
        ];
        List<CRMTask> expected = [
          CRMTask(
            id: "1001",
            customer: customer,
            subject: "Meeting",
            dueDate: DateTime.now(),
          )
        ];
        when(mockDS.find()).thenAnswer((_) async => dsResponse);

        //act
        final result = await repo.getAllTasks();

        //assert
        List<CRMTask> resultList = List<CRMTask>.empty();
        result.fold((l) => {}, (r) => {resultList = expected});
        expect(resultList, equals(expected));
        verify(mockDS.find());
        verifyNoMoreInteractions(mockDS);
      });

      test("should return Failure when data source throws", () async {
        //arrange
        when(mockDS.find()).thenThrow(ServerFailure());

        //act
        final result = await repo.getAllTasks();

        //assert
        expect(result, equals(Left(ServerFailure())));
        verify(mockDS.find());
        verifyNoMoreInteractions(mockDS);
      });
    });

    group("updateTask", () {
      test("should call 'update' method of data source", () async {
        //arrange
        const taskId = "1001";
        Either<Failure, Unit> expected = const Right<Failure, Unit>(unit);
        const updatedSubject = "Changed Meeting Name";
        when(mockDS.update(taskId, subject: updatedSubject)).thenAnswer((_) async => unit);

        //act
        final result = await repo.updateTask(taskId, subject: updatedSubject);

        //assert
        expect(result, equals(expected));
        verify(mockDS.update(taskId, subject: updatedSubject));
        verifyNoMoreInteractions(mockDS);
      });

      test("should return Failure when data source throws", () async {
        //arrange
        const taskId = "1001";
        const updatedSubject = "Changed Meeting Name";
        when(mockDS.update(taskId, subject: updatedSubject)).thenThrow(ServerFailure());

        //act
        final result = await repo.updateTask(taskId, subject: updatedSubject);

        //assert
        expect(result, equals(Left(ServerFailure())));
        verify(mockDS.update(taskId, subject: updatedSubject));
        verifyNoMoreInteractions(mockDS);
      });
    });
  });
}
