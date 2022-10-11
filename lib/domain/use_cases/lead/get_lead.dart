import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:dartz/dartz.dart';

abstract class GetLead {
  Future<Either<Failure, Customer>> execute(String leadId);
}
