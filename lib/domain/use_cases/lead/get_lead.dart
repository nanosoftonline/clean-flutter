import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:crm/domain/repositories/interfaces/customer_repository.dart';
import 'package:dartz/dartz.dart';

abstract class GetLead {
  Future<Either<Failure, Customer>> execute(String leadId);
}

class GetLeadImpl implements GetLead {
  CustomerRepository customerRepository;
  GetLeadImpl(this.customerRepository);

  @override
  Future<Either<Failure, Customer>> execute(String leadId) async {
    final result = await customerRepository.getCustomer(leadId);
    return result;
  }
}
