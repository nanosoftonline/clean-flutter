import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:crm/domain/use_cases/customer/get_all_customers.dart';
import 'package:crm/presentation/view_models/customer/list.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_hooks_test/flutter_hooks_test.dart';

class MockGetAllCustomers extends Mock implements GetAllCustomers {}

void main() {
  late GetAllCustomers mockGetAllCustomersUseCase;

  setUp(() {
    mockGetAllCustomersUseCase = MockGetAllCustomers();
  });

  testWidgets("should return data from use case", (WidgetTester tester) async {
    //arrange
    const useCaseResult = Right<Failure, List<Customer>>([
      Customer(
        id: "123",
        email: "john@company.com",
        name: "John",
      ),
      Customer(
        id: "124",
        email: "jane@company.com",
        name: "Jane",
      )
    ]);

    when(() => mockGetAllCustomersUseCase.execute()).thenAnswer((_) async => useCaseResult);
    final result = await buildHook((_) => useCustomerListViewModel(getAllCustomers: mockGetAllCustomersUseCase));

    //act
    await act(() => result.current.fetchData());

    //assert
    verify(() => mockGetAllCustomersUseCase.execute());
    expect(result.current.data.length, 2);
  });

  testWidgets("should return error message ", (WidgetTester tester) async {
    //arrange
    Either<Failure, List<Customer>> useCaseResult = Left(ServerFailure());
    when(() => mockGetAllCustomersUseCase.execute()).thenAnswer((_) async => useCaseResult);
    final result = await buildHook((_) => useCustomerListViewModel(getAllCustomers: mockGetAllCustomersUseCase));

    //act
    await act(() => result.current.fetchData());

    //assert
    verify(() => mockGetAllCustomersUseCase.execute());
    expect(result.current.error, 'Error Fetching Customers!');
  });
}
