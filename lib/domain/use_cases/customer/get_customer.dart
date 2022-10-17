import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:crm/domain/repositories/interfaces/customer_repository.dart';
import 'package:dartz/dartz.dart';

abstract class GetCustomer {
  Future<Either<Failure, Customer>> execute(String customerId);
}

class GetCustomerImpl implements GetCustomer {
  CustomerRepository customerRepository;
  GetCustomerImpl(this.customerRepository);

  @override
  Future<Either<Failure, Customer>> execute(String customerId) async {
    final result = await customerRepository.getCustomer(customerId);
    return result;
  }
}
