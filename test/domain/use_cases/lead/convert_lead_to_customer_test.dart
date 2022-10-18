import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:crm/domain/repositories/interfaces/customer_repository.dart';
import 'package:crm/domain/use_cases/lead/convert_lead_to_customer.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import "convert_lead_to_customer_test.mocks.dart";

@GenerateMocks([CustomerRepository])
void main() {
  late CustomerRepository mockCustomerRepository;
  late ConvertLeadToCustomer usecase;
  setUp(() {
    mockCustomerRepository = MockCustomerRepository();
    usecase = ConvertLeadToCustomerImpl(mockCustomerRepository);
  });

  test("should call update customer method to update the type", () async {
    //arrange
    const id = "123";
    Either<Failure, Unit> repoResponse = const Right(unit);
    when(mockCustomerRepository.updateCustomer(id, customerType: CustomerType.lead))
        .thenAnswer((realInvocation) async => repoResponse);

    //act
    final result = await usecase.execute(id);

    //assert
    expect(result, equals(repoResponse));
    verify(mockCustomerRepository.updateCustomer(id, customerType: CustomerType.lead));
    verifyNoMoreInteractions(mockCustomerRepository);
  });
}
