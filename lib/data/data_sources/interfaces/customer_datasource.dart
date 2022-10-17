import 'package:crm/data/entities/customer_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CustomerDataSource {
  Future<List<CustomerEntity>> getAll();
  Future<CustomerEntity> getOne(String id);
  Future<Unit> create(CustomerEntity data);
  Future<Unit> delete(String id);
  Future<Unit> update(String id, dynamic data);
}
