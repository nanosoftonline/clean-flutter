import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:crm/domain/use_cases/customer/create_customer.dart';
import 'package:crm/presentation/view_models/customer/new.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_hooks_test/flutter_hooks_test.dart';

class MockCreateCustomer extends Mock implements CreateCustomer {}

void main() {
  late CreateCustomer mockCreateCustomerUseCase;
  setUp(() {
    mockCreateCustomerUseCase = MockCreateCustomer();
  });

  testWidgets("should call saveCustomerData", (tester) async {
    //arrange

    const inputData = Customer(name: "John", email: "john@email.com");
    Either<Failure, Unit> useCaseResult = const Right(unit);
    when(() => mockCreateCustomerUseCase.execute(inputData)).thenAnswer((_) async => useCaseResult);
    final result = await buildHook((_) => useCustomerNewViewModel(createCustomer: mockCreateCustomerUseCase));

    //act
    await act(() => result.current.saveCustomerData(name: inputData.name, email: inputData.email));

    //assert
    verify(() => mockCreateCustomerUseCase.execute(inputData));
    verifyNoMoreInteractions(mockCreateCustomerUseCase);
  });

  testWidgets("should set Error message if saveCustomerData fails", (tester) async {
    //arrange
    const inputData = Customer(name: "John", email: "john@email.com");
    when(() => mockCreateCustomerUseCase.execute(inputData)).thenAnswer((_) async => Left(ServerFailure()));
    final result = await buildHook((_) => useCustomerNewViewModel(createCustomer: mockCreateCustomerUseCase));

    //act
    await act(() => result.current.saveCustomerData(name: inputData.name, email: inputData.email));

    //assert
    verify(() => mockCreateCustomerUseCase.execute(inputData));
    expect(result.current.error, "Error Saving Customer Data!");
  });
}
