import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:dartz/dartz.dart';

abstract class UpdateCustomer {
  Future<Either<Failure, void>> execute(String customerId, Customer data);
}
