import 'package:crm/data/data_sources/interfaces/customer_datasource.dart';
import 'package:crm/data/entities/customer_entity.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/repositories/interfaces/customer_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  CustomerDataSource customerDataSource;
  CustomerRepositoryImpl(this.customerDataSource);

  @override
  Future<Either<Failure, Unit>> createCustomer(Customer data) async {
    try {
      final result = await customerDataSource.create(CustomerEntity(
        id: data.id,
        customerName: data.name,
        emailAddress: data.email,
        active: data.isActive,
        type: data.customerType,
      ));
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCustomer(String id) async {
    try {
      final result = await customerDataSource.delete(id);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Customer>>> getAllCustomers(CustomerType customerType) async {
    try {
      List<CustomerEntity> result = await customerDataSource.find(type: customerType);
      return Right(result
          .map((e) => Customer(
                id: e.id,
                name: e.customerName,
                email: e.emailAddress,
              ))
          .toList());
    } catch (e) {
      debugPrint(e.toString());
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateCustomer(
    String id, {
    String? name,
    String? email,
    CustomerType? customerType,
    bool? isActive,
  }) async {
    try {
      final result = await customerDataSource.update(id, customerName: name, emailAddress: email, active: isActive);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Customer>> getCustomer(String id) async {
    try {
      final result = await customerDataSource.findOne(id);
      return Right(Customer(id: result.id, email: result.emailAddress, name: result.customerName));
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
