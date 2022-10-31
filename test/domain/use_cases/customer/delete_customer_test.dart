import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/repositories/interfaces/customer_repository.dart';
import 'package:crm/domain/use_cases/customer/delete_customer.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';

class MockCustomerRepository extends Mock implements CustomerRepository {}

void main() {
  late CustomerRepository mockCustomerRepository;
  late DeleteCustomer usecase;

  setUp(() {
    mockCustomerRepository = MockCustomerRepository();
    usecase = DeleteCustomerImpl(mockCustomerRepository);
  });

  test("should call the deleteCustmer customer repo method", () async {
    //arrange
    var repoResult = const Right<Failure, Unit>(unit);
    var customerId = const Uuid().v4();

    when(() => mockCustomerRepository.deleteCustomer(customerId)).thenAnswer((_) async => repoResult);

    //act
    final result = await usecase.execute(customerId);

    //assert
    expect(result, equals(repoResult));
    verify(() => mockCustomerRepository.deleteCustomer(customerId));
    verifyNoMoreInteractions(mockCustomerRepository);
  });
}
