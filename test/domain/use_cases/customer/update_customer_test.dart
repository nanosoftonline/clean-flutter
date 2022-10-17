import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:crm/domain/repositories/interfaces/customer_repository.dart';
import 'package:crm/domain/use_cases/customer/update_customer_details.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'update_customer_test.mocks.dart';

@GenerateMocks([CustomerRepository])
void main() {
  late CustomerRepository mockCustomerRepository;
  late UpdateCustomer usecase;
  setUp(() {
    mockCustomerRepository = MockCustomerRepository();
    usecase = UpdateCustomerImpl(mockCustomerRepository);
  });

  test("should call updateCustomer method of customer repo with id and customer data", () async {
    //arrange
    const customerId = "123";
    const customerData = Customer(id: "123", name: "Jim", email: "jim@gmail.com");
    Either<Failure, Unit> repoResponse = Right(unit);
    when(mockCustomerRepository.updateCustomer(customerId, customerData))
        .thenAnswer((realInvocation) async => repoResponse);

    //act
    final result = await usecase.execute(customerId, customerData);

    //assert
    expect(result, equals(repoResponse));
    verify(mockCustomerRepository.updateCustomer(customerId, customerData));
    verifyNoMoreInteractions(mockCustomerRepository);
  });
}
