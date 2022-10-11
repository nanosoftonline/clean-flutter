import 'package:crm/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class MakeCustomerActive {
  Future<Either<Failure, void>> execute(String customerId);
}
