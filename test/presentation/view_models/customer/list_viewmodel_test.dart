import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:crm/domain/use_cases/customer/get_all_customers.dart';
import 'package:crm/presentation/view_models/customer/list.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'list_viewmodel_test.mocks.dart';

class TestWidget extends HookWidget {
  const TestWidget(this.vm, {super.key});
  final CustomerListViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(vm.data.length.toString()),
        Text(vm.error),
        TextButton(
          onPressed: () {
            vm.fetchData();
          },
          child: const Text("Fetch Data"),
        )
      ],
    );
  }
}

@GenerateMocks([GetAllCustomers])
void main() {
  late GetAllCustomers mockGetAllCustomersUseCase;

  setUp(() {
    mockGetAllCustomersUseCase = MockGetAllCustomers();
  });

  testWidgets("should return data from use case", (WidgetTester tester) async {
    //arrange
    var useCaseResult = const Right<Failure, List<Customer>>([
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

    when(mockGetAllCustomersUseCase.execute()).thenAnswer((_) async => useCaseResult);
    //act
    await tester.pumpWidget(HookBuilder(builder: (context) {
      final viewModel = useCustomerListViewModel(getAllCustomers: mockGetAllCustomersUseCase);
      return MaterialApp(home: TestWidget(viewModel));
    }));

    //assert
    expect(find.text('0'), findsOneWidget);
    await tester.tap(find.byType(TextButton));
    await tester.pump();
    expect(find.text('2'), findsOneWidget);
  });

  testWidgets("should return error message ", (WidgetTester tester) async {
    //arrange
    Either<Failure, List<Customer>> useCaseResult = Left(ServerFailure());
    when(mockGetAllCustomersUseCase.execute()).thenAnswer((_) async => useCaseResult);

    //act
    await tester.pumpWidget(HookBuilder(builder: (context) {
      final viewModel = useCustomerListViewModel(getAllCustomers: mockGetAllCustomersUseCase);
      return MaterialApp(home: TestWidget(viewModel));
    }));

    //assert
    expect(find.text(''), findsOneWidget);
    await tester.tap(find.byType(TextButton));
    await tester.pump();
    expect(find.text('Error Fetching Customers!'), findsOneWidget);
  });
}
