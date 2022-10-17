import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/repositories/interfaces/customer_repository.dart';
import 'package:crm/domain/use_cases/customer/make_customer_active.dart';
import 'package:dartz/dartz.dart';
import "package:mockito/mockito.dart";
import "package:mockito/annotations.dart";
import 'package:flutter_test/flutter_test.dart';

import 'make_customer_active_test.mocks.dart';

@GenerateMocks([CustomerRepository])
void main() {
  late CustomerRepository mockCustomerRepository;
  late MakeCustomerActive usecase;

  setUpAll(() {
    mockCustomerRepository = MockCustomerRepository();
    usecase = MakeCustomerActiveImpl(mockCustomerRepository);
  });

  test("should call the updateCustomer repo method with customerId and isActive: true successfully", () async {
    //arrange
    const customerId = "1234";
    const data = {"isActive": true};
    Either<Failure, Unit> repoResponse = const Right(unit);
    when(mockCustomerRepository.updateCustomer(customerId, isActive: true)).thenAnswer((_) async => repoResponse);

    //act
    final result = await usecase.execute(customerId);

    //assert
    expect(result, equals(repoResponse));
    verify(mockCustomerRepository.updateCustomer(customerId, isActive: true));
    verifyNoMoreInteractions(mockCustomerRepository);
  });
}
