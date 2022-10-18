import 'package:crm/data/entities/customer_entity.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:dartz/dartz.dart';

abstract class CustomerDataSource {
  Future<List<CustomerEntity>> find({
    String? customerName,
    CustomerType? type,
    String? id,
    String? emailAddress,
    bool? active,
  });
  Future<CustomerEntity> findOne(String id);
  Future<Unit> create(CustomerEntity data);
  Future<Unit> delete(String id);
  Future<Unit> update(
    String id, {
    String? customerName,
    String? emailAddress,
    CustomerType? type,
    bool? active,
  });
}
