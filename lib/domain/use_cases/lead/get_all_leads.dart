import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:dartz/dartz.dart';

abstract class GetAllLeads {
  Future<Either<Failure, List<Customer>>> execute();
}
