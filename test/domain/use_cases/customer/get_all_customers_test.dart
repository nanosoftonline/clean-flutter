import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:crm/domain/repositories/implementations/customer_repository_impl.dart';
import 'package:crm/domain/use_cases/customer/get_all_customers.dart';

import 'get_all_customers_test.mocks.dart';

@GenerateMocks([CustomerRepository])
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

    when(mockCustomerRepository.getAllCustomers()).thenAnswer((_) async => repoResult);

    final result = await usecase.execute();

    expect(result, equals(repoResult));
    verify(mockCustomerRepository.getAllCustomers());
    verifyNoMoreInteractions(mockCustomerRepository);
  });
}
