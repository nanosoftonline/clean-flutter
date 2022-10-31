import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/repositories/interfaces/customer_repository.dart';
import 'package:crm/domain/use_cases/customer/make_customer_inactive.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCustomerRepository extends Mock implements CustomerRepository {}

void main() {
  late CustomerRepository mockCustomerRepository;
  late MakeCustomerInActive usecase;
  setUp(() {
    mockCustomerRepository = MockCustomerRepository();
    usecase = MakeCustomerInActiveImpl(mockCustomerRepository);
  });

  test("should all updateCustomer repo method with customerId and things to change", () async {
    //arrange
    const customerId = "1234";
    Either<Failure, Unit> repoResponse = const Right(unit);
    when(() => mockCustomerRepository.updateCustomer(customerId, isActive: false))
        .thenAnswer((_) async => repoResponse);

    //act
    final result = await usecase.execute(customerId);

    //assert
    expect(result, equals(repoResponse));
    verify(() => mockCustomerRepository.updateCustomer(customerId, isActive: false));
    verifyNoMoreInteractions(mockCustomerRepository);
  });
}
