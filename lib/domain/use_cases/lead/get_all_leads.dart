import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:crm/domain/repositories/interfaces/customer_repository.dart';
import 'package:dartz/dartz.dart';

abstract class GetAllLeads {
  Future<Either<Failure, List<Customer>>> execute();
}

class GetAllLeadsImpl implements GetAllLeads {
  CustomerRepository customerRepository;
  GetAllLeadsImpl(this.customerRepository);
  @override
  Future<Either<Failure, List<Customer>>> execute() async {
    final result = await customerRepository.getAllCustomers(CustomerType.lead);
    return result;
  }
}
