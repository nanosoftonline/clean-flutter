import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/repositories/interfaces/customer_repository.dart';
import 'package:dartz/dartz.dart';

abstract class DeleteLead {
  Future<Either<Failure, void>> execute(String leadId);
}

class DeleteLeadImpl implements DeleteLead {
  CustomerRepository customerRepository;
  DeleteLeadImpl(this.customerRepository);

  @override
  Future<Either<Failure, void>> execute(String leadId) async {
    final result = await customerRepository.deleteCustomer(leadId);
    return result;
  }
}
