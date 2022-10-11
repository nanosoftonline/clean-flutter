import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:dartz/dartz.dart';

abstract class CreateCustomer {
  Future<Either<Failure, void>> execute(Customer customer);
}
