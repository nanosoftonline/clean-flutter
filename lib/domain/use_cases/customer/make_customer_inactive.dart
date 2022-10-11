import 'package:crm/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class MakeCustomerInActive {
  Future<Either<Failure, void>> execute(String customerId);
}
