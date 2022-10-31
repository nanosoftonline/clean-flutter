/**
 * Unit tests for customer edit view model
 * Dependecies: UpdateCustomer, GetCustomer
 * 
 */

import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:crm/domain/use_cases/customer/get_customer.dart';
import 'package:crm/domain/use_cases/customer/update_customer_details.dart';
import 'package:crm/presentation/view_models/customer/edit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class TestWidget extends HookWidget {
  const TestWidget(this.vm, {super.key});
  final CustomerEditViewModel vm;

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
          child: const Text("FetchCustomerData"),
        ),
        TextButton(
          onPressed: () {
            vm.saveCustomerData(name: "Test Name", email: "test@email.com");
          },
          child: const Text("SaveCustomerData"),
        )
      ],
    );
  }
}

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

    when(() => mockUpdateCustomerUseCase.execute(expected.id!, name: "Test Name", email: "test@email.com"))
        .thenAnswer((_) async => const Right(unit));

    //act
    await tester.pumpWidget(HookBuilder(builder: (context) {
      final viewModel = useCustomerEditViewModel(
        getCustomer: mockGetCustomerUseCase,
        updateCustomer: mockUpdateCustomerUseCase,
      );
      return MaterialApp(home: TestWidget(viewModel));
    }));

    //assert Fetch
    await tester.tap(find.text("FetchCustomerData"));
    await tester.pump();
    expect(
      find.text(expected.toString()),
      findsOneWidget,
    );

    //assert save
    await tester.tap(find.text("SaveCustomerData"));
    await tester.pump();
    verify(() => mockUpdateCustomerUseCase.execute(expected.id!, name: "Test Name", email: "test@email.com"));
  });

  testWidgets("should set Error message if getCustomer fails", (tester) async {
    //arrange
    when(() => mockGetCustomerUseCase.execute("123")).thenAnswer((_) async => Left(ServerFailure()));

    //act
    await tester.pumpWidget(HookBuilder(builder: (context) {
      final viewModel = useCustomerEditViewModel(
        getCustomer: mockGetCustomerUseCase,
        updateCustomer: mockUpdateCustomerUseCase,
      );
      return MaterialApp(home: TestWidget(viewModel));
    }));

    //assert Fetch
    await tester.tap(find.text("FetchCustomerData"));
    await tester.pump();
    expect(
      find.text('Error Fetching Customer!'),
      findsOneWidget,
    );
  });

  testWidgets("should set Error message if updateCustomer fails", (tester) async {
    //arrange
    const expected = Customer(id: "123", name: "John", email: "john@email.com");
    Either<Failure, Customer> useCaseResult = const Right(expected);
    when(() => mockGetCustomerUseCase.execute(expected.id!)).thenAnswer((_) async => useCaseResult);

    when(() => mockUpdateCustomerUseCase.execute(expected.id!, name: "Test Name", email: "test@email.com"))
        .thenAnswer((_) async => Left(ServerFailure()));

    //act
    await tester.pumpWidget(HookBuilder(builder: (context) {
      final viewModel = useCustomerEditViewModel(
        getCustomer: mockGetCustomerUseCase,
        updateCustomer: mockUpdateCustomerUseCase,
      );
      return MaterialApp(home: TestWidget(viewModel));
    }));

    //assert Fetch
    await tester.tap(find.text("FetchCustomerData"));
    await tester.pump();
    expect(
      find.text(expected.toString()),
      findsOneWidget,
    );

    //assert save
    await tester.tap(find.text("SaveCustomerData"));
    await tester.pump();
    expect(
      find.text('Error Saving Customer Data!'),
      findsOneWidget,
    );
  });
}
