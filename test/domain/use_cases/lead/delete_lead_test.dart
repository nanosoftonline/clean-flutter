import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/repositories/interfaces/customer_repository.dart';
import 'package:crm/domain/use_cases/lead/delete_lead.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCustomerRepository extends Mock implements CustomerRepository {}

void main() {
  late CustomerRepository mockCustomerRepository;
  late DeleteLead usecase;
  setUp(() {
    mockCustomerRepository = MockCustomerRepository();
    usecase = DeleteLeadImpl(mockCustomerRepository);
  });

  test("should call the deleteCustomer repo method", () async {
    //arrange
    const id = "123";
    Either<Failure, Unit> repoResponse = const Right(unit);
    when(() => mockCustomerRepository.deleteCustomer(id)).thenAnswer((realInvocation) async => repoResponse);

    //act
    final result = await usecase.execute(id);

    //assert
    expect(result, equals(repoResponse));
    verify(() => mockCustomerRepository.deleteCustomer(id));
    verifyNoMoreInteractions(mockCustomerRepository);
  });
}
