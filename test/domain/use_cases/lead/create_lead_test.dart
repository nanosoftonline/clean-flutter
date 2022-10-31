import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:crm/domain/repositories/interfaces/customer_repository.dart';
import 'package:crm/domain/use_cases/lead/create_lead.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCustomerRepository extends Mock implements CustomerRepository {}

void main() {
  late CustomerRepository mockCustomerRepository;
  late CreateLead usecase;
  setUp(() {
    mockCustomerRepository = MockCustomerRepository();
    usecase = CreateLeadImpl(mockCustomerRepository);
  });

  test("should call the createCustomer with lead type", () async {
    //arrange
    Customer customer = const Customer(
      id: "123",
      name: "Person",
      email: "person@email.com",
      customerType: CustomerType.lead,
    );
    Either<Failure, Unit> repoResponse = const Right(unit);
    when(() => mockCustomerRepository.createCustomer(customer)).thenAnswer((realInvocation) async => repoResponse);

    //act
    final result = await usecase.execute(customer);

    //assert
    expect(result, equals(repoResponse));
    verify(() => mockCustomerRepository.createCustomer(customer));
    verifyNoMoreInteractions(mockCustomerRepository);
  });
}
