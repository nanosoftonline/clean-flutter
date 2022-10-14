import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:crm/domain/repositories/implementations/customer_repository_impl.dart';
import 'package:dartz/dartz.dart';

abstract class CreateCustomer {
  Future<Either<Failure, Unit>> execute(Customer customer);
}

class CreateCustomerImpl implements CreateCustomer {
  final CustomerRepository customerRepository;
  CreateCustomerImpl(this.customerRepository);

  @override
  Future<Either<Failure, Unit>> execute(Customer customer) async {
    return await customerRepository.createCustomer(customer);
  }
}
