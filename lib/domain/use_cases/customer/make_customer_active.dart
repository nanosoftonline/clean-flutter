import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/repositories/interfaces/customer_repository.dart';
import 'package:dartz/dartz.dart';

abstract class MakeCustomerActive {
  Future<Either<Failure, Unit>> execute(String customerId);
}

class MakeCustomerActiveImpl implements MakeCustomerActive {
  CustomerRepository customerRepository;

  MakeCustomerActiveImpl(this.customerRepository);

  @override
  Future<Either<Failure, Unit>> execute(String customerId) async {
    final result = await customerRepository.updateCustomer(customerId, isActive: true);
    return result;
  }
}
