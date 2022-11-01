import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:crm/domain/use_cases/customer/delete_customer.dart';
import 'package:crm/domain/use_cases/customer/get_customer.dart';
import 'package:crm/presentation/view_models/customer/detail.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class TestWidget extends HookWidget {
  const TestWidget(this.vm, {super.key});
  final CustomerDetailViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(vm.data.toString()),
        Text(vm.error),
        TextButton(
          onPressed: () {
            vm.fetchCustomerData("123");
          },
          child: const Text("Get Customer"),
        ),
        TextButton(
          onPressed: () {
            vm.deleteCustomer("123");
          },
          child: const Text("Delete Customer"),
        ),
      ],
    );
  }
}

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

    //act
    await tester.pumpWidget(HookBuilder(builder: (context) {
      final viewModel = useCustomerDetailViewModel(
        getCustomerUseCase: mockGetCustomerUseCase,
        deleteCustomerUseCase: mockDeleteCustomerUseCase,
      );
      return MaterialApp(home: TestWidget(viewModel));
    }));

    //assert Fetch
    await tester.tap(find.text("Get Customer"));
    await tester.pump();
    verify(() => mockGetCustomerUseCase.execute(expected.id!));
  });

  testWidgets("should set Error message if getCustomer fails", (tester) async {
    //arrange
    when(() => mockGetCustomerUseCase.execute("123")).thenAnswer((_) async => Left(ServerFailure()));

    //act
    await tester.pumpWidget(HookBuilder(builder: (context) {
      final viewModel = useCustomerDetailViewModel(
        getCustomerUseCase: mockGetCustomerUseCase,
        deleteCustomerUseCase: mockDeleteCustomerUseCase,
      );
      return MaterialApp(home: TestWidget(viewModel));
    }));

    //assert Fetch
    await tester.tap(find.text("Get Customer"));
    await tester.pump();
    expect(
      find.text('Error Fetching Customer!'),
      findsOneWidget,
    );
  });
}
