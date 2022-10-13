import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:crm/domain/repositories/implementations/customer_repository_impl.dart';
import 'package:dartz/dartz.dart';

abstract class GetAllCustomers {
  Future<Either<Failure, List<Customer>>?> execute();
}

class GetAllCustomersImpl implements GetAllCustomers {
  final CustomerRepository customerRepository;

  GetAllCustomersImpl(this.customerRepository);

  @override
  Future<Either<Failure, List<Customer>>?> execute() async {
    return await customerRepository.getAllCustomers();
  }
}
