import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
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
          child: const Text("FetchCustomerData"),
        ),
      ],
    );
  }
}

class MockGetCustomer extends Mock implements GetCustomer {}

void main() {
  late GetCustomer mockGetCustomerUseCase;
  setUp(() {
    mockGetCustomerUseCase = MockGetCustomer();
  });

  testWidgets("should call getCustomer", (tester) async {
    //arrange
    const expected = Customer(id: "123", name: "John", email: "john@email.com");
    Either<Failure, Customer> useCaseResult = const Right(expected);
    when(() => mockGetCustomerUseCase.execute(expected.id!)).thenAnswer((_) async => useCaseResult);

    //act
    await tester.pumpWidget(HookBuilder(builder: (context) {
      final viewModel = useCustomerDetailViewModel(getCustomer: mockGetCustomerUseCase);
      return MaterialApp(home: TestWidget(viewModel));
    }));

    //assert Fetch
    await tester.tap(find.text("FetchCustomerData"));
    await tester.pump();
    verify(() => mockGetCustomerUseCase.execute(expected.id!));
  });

  testWidgets("should set Error message if getCustomer fails", (tester) async {
    //arrange
    when(() => mockGetCustomerUseCase.execute("123")).thenAnswer((_) async => Left(ServerFailure()));

    //act
    await tester.pumpWidget(HookBuilder(builder: (context) {
      final viewModel = useCustomerDetailViewModel(getCustomer: mockGetCustomerUseCase);
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
}
