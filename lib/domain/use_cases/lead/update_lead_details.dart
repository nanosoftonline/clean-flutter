import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:dartz/dartz.dart';

abstract class UpdateLead {
  Future<Either<Failure, void>> execute(String leadId, Customer data);
}
