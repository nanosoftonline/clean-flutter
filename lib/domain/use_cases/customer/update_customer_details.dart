import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/repositories/interfaces/customer_repository.dart';
import 'package:dartz/dartz.dart';

abstract class UpdateCustomer {
  Future<Either<Failure, Unit>> execute(String customerId, {String? name, String? email});
}

class UpdateCustomerImpl implements UpdateCustomer {
  CustomerRepository customerRepository;
  UpdateCustomerImpl(this.customerRepository);

  @override
  Future<Either<Failure, Unit>> execute(String customerId, {String? name, String? email}) async {
    final result = await customerRepository.updateCustomer(customerId, name: name, email: email);
    return result;
  }
}
