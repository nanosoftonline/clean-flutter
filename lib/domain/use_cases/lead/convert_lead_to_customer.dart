import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:crm/domain/repositories/interfaces/customer_repository.dart';
import 'package:dartz/dartz.dart';

abstract class ConvertLeadToCustomer {
  Future<Either<Failure, void>> execute(String leadId);
}

class ConvertLeadToCustomerImpl implements ConvertLeadToCustomer {
  CustomerRepository customerRepository;
  ConvertLeadToCustomerImpl(this.customerRepository);

  @override
  Future<Either<Failure, void>> execute(String leadId) async {
    final result = await customerRepository.updateCustomer(leadId, customerType: CustomerType.lead);
    return result;
  }
}
