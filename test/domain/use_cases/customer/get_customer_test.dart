import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:crm/domain/repositories/implementations/customer_repository_impl.dart';
import 'package:crm/domain/use_cases/customer/get_customer.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'create_customer_test.mocks.dart';

@GenerateMocks([CustomerRepository])
void main() {
  late CustomerRepository mockCustomerRepository;
  late GetCustomer usecase;

  setUp(() {
    mockCustomerRepository = MockCustomerRepository();
    usecase = GetCustomerImpl(mockCustomerRepository);
  });
  test("should return a customer from the customer repository if an id is provided", () async {
    //arrange
    const customerId = "1234";
    Either<Failure, Customer> repoResponse =
        const Right(Customer(id: customerId, name: "John", email: "john@gmail.com"));
    when(mockCustomerRepository.getCustomer(customerId)).thenAnswer((_) async => repoResponse);

    //act
    final result = await usecase.execute(customerId);

    //assert
    expect(result, equals(repoResponse));
    verify(mockCustomerRepository.getCustomer(customerId));
    verifyNoMoreInteractions(mockCustomerRepository);
  });
}
