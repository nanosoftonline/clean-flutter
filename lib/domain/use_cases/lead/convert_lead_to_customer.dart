import 'package:crm/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ConvertLeadToCustomer {
  Future<Either<Failure, void>> execute(String leadId);
}
