import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/repositories/interfaces/customer_repository.dart';
import 'package:crm/domain/use_cases/customer/make_customer_inactive.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'make_customer_active_test.mocks.dart';

@GenerateMocks([CustomerRepository])
void main() {
  late CustomerRepository mockCustomerRepository;
  late MakeCustomerInActive usecase;
  setUpAll(() {
    mockCustomerRepository = MockCustomerRepository();
    usecase = MakeCustomerInActiveImpl(mockCustomerRepository);
  });

  test("should all updateCustomer repo method with customerId and things to change", () async {
    //arrange
    const customerId = "1234";
    const data = {"isActive": false};
    Either<Failure, Unit> repoResponse = const Right(unit);
    when(mockCustomerRepository.updateCustomer(customerId, data)).thenAnswer((_) async => repoResponse);
  });
}
