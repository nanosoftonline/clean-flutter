import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:crm/domain/repositories/interfaces/customer_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:crm/domain/use_cases/customer/get_all_customers.dart';
import 'package:mocktail/mocktail.dart';

class MockCustomerRepository extends Mock implements CustomerRepository {}

void main() {
  late CustomerRepository mockCustomerRepository;
  late GetAllCustomers usecase;

  setUp(() {
    mockCustomerRepository = MockCustomerRepository();
    usecase = GetAllCustomersImpl(mockCustomerRepository);
  });

  test("should get all customers from the customer repository", () async {
    Either<Failure, List<Customer>> repoResult = const Right<Failure, List<Customer>>([
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

    when(() => mockCustomerRepository.getAllCustomers(CustomerType.customer)).thenAnswer((_) async => repoResult);

    final result = await usecase.execute();

    expect(result, equals(repoResult));
    verify(() => mockCustomerRepository.getAllCustomers(CustomerType.customer));
    verifyNoMoreInteractions(mockCustomerRepository);
  });
}
