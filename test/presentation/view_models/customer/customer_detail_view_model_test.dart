import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:crm/domain/use_cases/customer/delete_customer.dart';
import 'package:crm/domain/use_cases/customer/get_customer.dart';
import 'package:crm/presentation/view_models/customer/detail.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_hooks_test/flutter_hooks_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCustomer extends Mock implements GetCustomer {}

class MockDeleteCustomer extends Mock implements DeleteCustomer {}

void main() {
  late GetCustomer mockGetCustomerUseCase;
  late DeleteCustomer mockDeleteCustomerUseCase;
  setUp(() {
    mockGetCustomerUseCase = MockGetCustomer();
    mockDeleteCustomerUseCase = MockDeleteCustomer();
  });

  testWidgets("should call getCustomer", (tester) async {
    //arrange
    const expected = Customer(id: "123", name: "John", email: "john@email.com");
    Either<Failure, Customer> useCaseResult = const Right(expected);
    when(() => mockGetCustomerUseCase.execute(expected.id!)).thenAnswer((_) async => useCaseResult);
    when(() => mockDeleteCustomerUseCase.execute(expected.id!)).thenAnswer((_) async => const Right(unit));
    final result = await buildHook((_) => useCustomerDetailViewModel(
          getCustomerUseCase: mockGetCustomerUseCase,
          deleteCustomerUseCase: mockDeleteCustomerUseCase,
        ));

    //act and assert Fetch
    await act(() => result.current.fetchCustomerData(expected.id!));
    expect(result.current.data, expected);

    //act and assert Delete
    await act(() => result.current.deleteCustomer(expected.id!));
    verify(() => mockDeleteCustomerUseCase.execute(expected.id!));
  });

  testWidgets("should set Error message if getCustomer fails", (tester) async {
    //arrange
    when(() => mockGetCustomerUseCase.execute("123")).thenAnswer((_) async => Left(ServerFailure()));
    final result = await buildHook((_) => useCustomerDetailViewModel(
          getCustomerUseCase: mockGetCustomerUseCase,
          deleteCustomerUseCase: mockDeleteCustomerUseCase,
        ));

    //act
    await act(() => result.current.fetchCustomerData("123"));

    //assert Fetch
    expect(result.current.error, "Error Fetching Customer!");
  });

  testWidgets("should set Error message if deleteCustomer fails", (tester) async {
    //arrange
    when(() => mockDeleteCustomerUseCase.execute("123")).thenAnswer((_) async => Left(ServerFailure()));
    final result = await buildHook((_) => useCustomerDetailViewModel(
          getCustomerUseCase: mockGetCustomerUseCase,
          deleteCustomerUseCase: mockDeleteCustomerUseCase,
        ));

    //act
    await act(() => result.current.deleteCustomer("123"));

    //assert Fetch
    expect(result.current.error, "Error Deleting Customer!");
  });
}
