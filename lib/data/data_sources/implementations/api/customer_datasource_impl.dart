import 'package:crm/data/data_sources/interfaces/customer_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:crm/data/entities/customer_entity.dart';
import 'package:dio/dio.dart';

const String API_BASE = "http://localhost:4000";

class CustomerDataSourceImpl implements CustomerDataSource {
  @override
  Future<Unit> create(CustomerEntity data) async {
    await Dio().post("$API_BASE/customers", data: {
      "customerName": data.customerName,
      "emailAddress": data.emailAddress,
      "isActive": true,
      "type": "customer"
    });
    return unit;
  }

  @override
  Future<Unit> delete(String id) async {
    await Dio().delete("$API_BASE/customers/$id");
    return unit;
  }

  @override
  Future<List<CustomerEntity>> find({
    String? customerName,
    CustomerType? type,
    String? id,
    String? emailAddress,
    bool? active,
  }) async {
    var response = await Dio().get("$API_BASE/customers");
    List<CustomerEntity> list = [];
    response.data.forEach((d) {
      list.add(CustomerEntity(
        id: d["id"],
        customerName: d["customerName"],
        emailAddress: d["emailAddress"],
      ));
    });
    return list;
  }

  @override
  Future<CustomerEntity> findOne(String id) async {
    var response = await Dio().get("$API_BASE/customers/$id");
    CustomerEntity customer = CustomerEntity(
      id: response.data["id"],
      customerName: response.data["customerName"],
      emailAddress: response.data["emailAddress"],
    );
    return customer;
  }

  @override
  Future<Unit> update(
    String id, {
    String? customerName,
    String? emailAddress,
    CustomerType? type,
    bool? active,
  }) async {
    dynamic dataToUpdate = {};
    if (customerName != null) {
      dataToUpdate["customerName"] = customerName;
    }

    if (emailAddress != null) {
      dataToUpdate["emailAddress"] = emailAddress;
    }

    if (type != null) {
      dataToUpdate["type"] = type;
    }

    if (active != null) {
      dataToUpdate["isActive"] = active;
    }

    await Dio().put("$API_BASE/customers/$id", data: dataToUpdate);

    return unit;
  }
}
