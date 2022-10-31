import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:crm/domain/use_cases/customer/create_customer.dart';
import 'package:crm/domain/use_cases/customer/get_customer.dart';
import 'package:crm/presentation/view_models/customer/detail.dart';
import 'package:crm/presentation/view_models/customer/new.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class TestWidget extends HookWidget {
  const TestWidget(this.vm, {super.key});
  final CustomerNewViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(vm.data.toString()),
        Text(vm.error),
        TextButton(
          onPressed: () {
            vm.saveCustomerData(
              name: "John",
              email: "john@email.com",
            );
          },
          child: const Text("SaveCustomerData"),
        ),
      ],
    );
  }
}

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

    //act
    await tester.pumpWidget(HookBuilder(builder: (context) {
      final viewModel = useCustomerNewViewModel(createCustomer: mockCreateCustomerUseCase);
      return MaterialApp(home: TestWidget(viewModel));
    }));

    //assert Fetch
    await tester.tap(find.text("SaveCustomerData"));
    await tester.pump();
    verify(() => mockCreateCustomerUseCase.execute(inputData));
  });

  testWidgets("should set Error message if saveCustomerData fails", (tester) async {
    //arrange
    const inputData = Customer(name: "John", email: "john@email.com");
    when(() => mockCreateCustomerUseCase.execute(inputData)).thenAnswer((_) async => Left(ServerFailure()));

    //act
    await tester.pumpWidget(HookBuilder(builder: (context) {
      final viewModel = useCustomerNewViewModel(createCustomer: mockCreateCustomerUseCase);
      return MaterialApp(home: TestWidget(viewModel));
    }));

    //assert Fetch
    await tester.tap(find.text("SaveCustomerData"));
    await tester.pump();
    expect(
      find.text('Error Saving Customer Data!'),
      findsOneWidget,
    );
  });
}
