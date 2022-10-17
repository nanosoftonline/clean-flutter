import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/repositories/interfaces/customer_repository.dart';
import 'package:dartz/dartz.dart';

abstract class MakeCustomerInActive {
  Future<Either<Failure, Unit>> execute(String customerId);
}

class MakeCustomerInActiveImpl implements MakeCustomerInActive {
  CustomerRepository customerRepository;
  MakeCustomerInActiveImpl(this.customerRepository);

  @override
  Future<Either<Failure, Unit>> execute(String customerId) async {
    final result = await customerRepository.updateCustomer(customerId, {"inActive": false});
    return result;
  }
}
