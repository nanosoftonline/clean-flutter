import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:crm/domain/repositories/interfaces/customer_repository.dart';
import 'package:crm/domain/use_cases/lead/get_all_leads.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'get_all_leads_test.mocks.dart';

@GenerateMocks([CustomerRepository])
void main() {
  late CustomerRepository mockCustomerRepository;
  late GetAllLeads usecase;

  setUp(() {
    mockCustomerRepository = MockCustomerRepository();
    usecase = GetAllLeadsImpl(mockCustomerRepository);
  });

  test("should call getCustomers with customer type of lead", () async {
    //arrange
    Either<Failure, List<Customer>> repoResponse = const Right([
      Customer(
        email: "person@email.com",
        id: "123",
        name: "Person",
      )
    ]);
    when(mockCustomerRepository.getAllCustomers(CustomerType.lead)).thenAnswer((realInvocation) async => repoResponse);

    //act
    final result = await usecase.execute();

    //assert
    expect(result, equals(repoResponse));
  });
}
