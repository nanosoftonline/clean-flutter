import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';

import "package:dartz/dartz.dart";

abstract class CustomerRepository {
  Future<Either<Failure, List<Customer>>?> getAllCustomers();
  Future<Either<Failure, void>> createCustomer(Customer data);
  Future<Either<Failure, void>> deleteCustomer(String id);
  Future<Either<Failure, void>> updateCustomer(String id, Customer data);
}
