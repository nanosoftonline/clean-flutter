import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/repositories/interfaces/customer_repository.dart';
import 'package:crm/domain/use_cases/customer/update_customer_details.dart';
import 'package:crm/domain/use_cases/lead/update_lead_details.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'update_lead_details_test.mocks.dart';

@GenerateMocks([CustomerRepository])
void main() {
  late CustomerRepository mockCustomerRepository;
  late UpdateLead usecase;

  setUp(() {
    mockCustomerRepository = MockCustomerRepository();
    usecase = UpdateLeadImpl(mockCustomerRepository);
  });

  test("should call the updateCustomer method of customer repo", () async {
    //arrange
    const id = "123";
    Either<Failure, Unit> repoResponse = const Right(unit);
    when(mockCustomerRepository.updateCustomer(id, name: "Jim")).thenAnswer((_) async => repoResponse);

    //act
    final result = await usecase.execute(id, name: "Jim");

    //assert
    expect(result, equals(repoResponse));
  });
}
