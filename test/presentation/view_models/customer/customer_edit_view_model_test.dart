import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:crm/domain/use_cases/customer/get_customer.dart';
import 'package:crm/domain/use_cases/customer/update_customer_details.dart';
import 'package:crm/presentation/view_models/customer/edit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_hooks_test/flutter_hooks_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCustomer extends Mock implements GetCustomer {}

class MockUpdateCustomer extends Mock implements UpdateCustomer {}

void main() {
  late GetCustomer mockGetCustomerUseCase;
  late UpdateCustomer mockUpdateCustomerUseCase;
  setUp(() {
    mockGetCustomerUseCase = MockGetCustomer();
    mockUpdateCustomerUseCase = MockUpdateCustomer();
  });

  testWidgets("should call fetchCustomerData and update state", (tester) async {
    //arrange
    const expected = Customer(id: "123", name: "John", email: "john@email.com");
    Either<Failure, Customer> useCaseResult = const Right(expected);
    when(() => mockGetCustomerUseCase.execute(expected.id!)).thenAnswer((_) async => useCaseResult);
    when(
      () => mockUpdateCustomerUseCase.execute(
        expected.id!,
        name: "Test Name",
        email: "test@email.com",
      ),
    ).thenAnswer((_) async => const Right(unit));
    final result = await buildHook((_) => useCustomerEditViewModel(
          getCustomer: mockGetCustomerUseCase,
          updateCustomer: mockUpdateCustomerUseCase,
        ));

    //act and assert Fetch
    await act(() => result.current.fetchCustomerData(expected.id!));
    verify(() => mockGetCustomerUseCase.execute(expected.id!));
    expect(result.current.data, expected);

    //act and assert Save
    await act(() => result.current.saveCustomerData(name: "Test Name", email: "test@email.com"));
    verify(() => mockUpdateCustomerUseCase.execute(expected.id!, name: "Test Name", email: "test@email.com"));
  });

  testWidgets("should set Error message if getCustomer fails", (tester) async {
    //arrange
    when(() => mockGetCustomerUseCase.execute("123")).thenAnswer((_) async => Left(ServerFailure()));
    final result = await buildHook((_) => useCustomerEditViewModel(
          getCustomer: mockGetCustomerUseCase,
          updateCustomer: mockUpdateCustomerUseCase,
        ));

    //act
    await act(() => result.current.fetchCustomerData("123"));

    //assert fetch Error
    expect(result.current.error, "Error Fetching Customer!");
  });

  testWidgets("should set Error message if updateCustomer fails", (tester) async {
    //arrange
    const expected = Customer(id: "123", name: "John", email: "john@email.com");
    Either<Failure, Customer> useCaseResult = const Right(expected);
    when(() => mockGetCustomerUseCase.execute(expected.id!)).thenAnswer((_) async => useCaseResult);

    when(() => mockUpdateCustomerUseCase.execute(expected.id!, name: "Test Name", email: "test@email.com"))
        .thenAnswer((_) async => Left(ServerFailure()));
    final result = await buildHook((_) => useCustomerEditViewModel(
          getCustomer: mockGetCustomerUseCase,
          updateCustomer: mockUpdateCustomerUseCase,
        ));

    //act
    await act(() => result.current.fetchCustomerData("123"));
    await act(() => result.current.saveCustomerData(name: "Test Name", email: "test@email.com"));

    //assert Save Error
    expect(result.current.error, "Error Saving Customer Data!");
  });
}
