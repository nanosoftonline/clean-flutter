import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:crm/domain/repositories/interfaces/customer_repository.dart';
import 'package:dartz/dartz.dart';

abstract class CreateLead {
  Future<Either<Failure, void>> execute(Customer customer);
}

class CreateLeadImpl implements CreateLead {
  CustomerRepository customerRepository;
  CreateLeadImpl(this.customerRepository);

  @override
  Future<Either<Failure, void>> execute(Customer customer) async {
    final result = await customerRepository.createCustomer(customer);
    return result;
  }
}
