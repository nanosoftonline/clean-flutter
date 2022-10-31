import 'package:crm/core/error/failures.dart';
import 'package:crm/data/data_sources/interfaces/customer_datasource.dart';
import 'package:crm/data/entities/customer_entity.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:crm/domain/repositories/implementations/customer_repository_impl.dart';
import 'package:crm/domain/repositories/interfaces/customer_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCustomerDataSource extends Mock implements CustomerDataSource {}

void main() {
  late CustomerDataSource mockDS;
  late CustomerRepository customerRepository;
  setUp(() {
    mockDS = MockCustomerDataSource();
    customerRepository = CustomerRepositoryImpl(mockDS);
  });

  group("getAllCustomers", () {
    test("should return all list of customer models", () async {
      //arrange
      List<CustomerEntity> dsResponse = [
        const CustomerEntity(
          id: "123",
          emailAddress: "paul@nanosoft.co.za",
          customerName: "Paul",
        )
      ];

      List<Customer> expected = [
        const Customer(
          id: "123",
          name: "Paul",
          email: "paul@nanosoft.co.za",
        )
      ];

      when(() => mockDS.find(type: CustomerType.customer)).thenAnswer((_) async => dsResponse);

      //act
      final result = await customerRepository.getAllCustomers(CustomerType.customer);

      //assert
      List<Customer> resultList = List<Customer>.empty();
      result.fold((l) => {}, (r) => {resultList = expected});
      expect(resultList, equals(expected));
    });

    test("should return Failure when data source throws", () async {
      //arrange
      Either<Failure, List<Customer>> expected = Left(ServerFailure());
      when(() => mockDS.find(type: CustomerType.lead)).thenThrow(ServerFailure());

      //act
      final result = await customerRepository.getAllCustomers(CustomerType.customer);

      //assert
      expect(result, equals(expected));
    });
  });

  group("getCustomer", () {
    test("should return one customer model by customerid", () async {
      //arrange
      const dsResponse = CustomerEntity(
        id: "123",
        emailAddress: "paul@nanosoft.co.za",
        customerName: "Paul",
      );
      Either<Failure, Customer> expected = const Right(Customer(
        id: "123",
        name: "Paul",
        email: "paul@nanosoft.co.za",
      ));
      const customerId = "123";
      when(() => mockDS.findOne(customerId)).thenAnswer((_) async => dsResponse);

      //act
      final result = await customerRepository.getCustomer(customerId);

      //assert
      expect(result, equals(expected));
    });

    test("should return Failure when data source throws", () async {
      //arrange
      Either<Failure, Customer> expected = Left(ServerFailure());
      const customerId = "123";
      when(() => mockDS.findOne(customerId)).thenThrow(ServerFailure());

      //act
      final result = await customerRepository.getCustomer(customerId);

      //assert
      expect(result, equals(expected));
    });
  });

  group("createCustomer", () {
    test("should call ds create method", () async {
      //arrange
      const customer = Customer(
        id: "123",
        email: "john@gmail.com",
        name: "John",
      );
      Either<Failure, Unit> expected = const Right<Failure, Unit>(unit);
      when(() => mockDS.create(const CustomerEntity(
            id: "123",
            emailAddress: "john@gmail.com",
            customerName: "John",
            active: true,
            type: CustomerType.customer,
          ))).thenAnswer((_) async => unit);

      //act
      final result = await customerRepository.createCustomer(customer);

      //assert
      expect(result, equals(expected));
    });

    test("should return Failure when data source throws", () async {
      //arrange
      const customer = Customer(id: "123", email: "john@gmail.com", name: "John");
      when(() => mockDS.create(const CustomerEntity(
            id: "123",
            emailAddress: "john@gmail.com",
            customerName: "John",
            active: true,
            type: CustomerType.customer,
          ))).thenThrow(ServerFailure());

      //act
      final result = await customerRepository.createCustomer(customer);

      //assert
      expect(result, equals(Left(ServerFailure())));
    });
  });

  group("deleteCustomer", () {
    test("should call 'delete' method of data source", () async {
      //arrange
      const customerId = "123";
      Either<Failure, Unit> expected = const Right<Failure, Unit>(unit);
      when(() => mockDS.delete(customerId)).thenAnswer((_) async => unit);

      //act
      final result = await customerRepository.deleteCustomer(customerId);

      //assert
      expect(result, equals(expected));
    });

    test("should return Failure when data source throws", () async {
      //arrange
      const customerId = "123";
      when(() => mockDS.delete(customerId)).thenThrow(ServerFailure());

      //act
      final result = await customerRepository.deleteCustomer(customerId);

      //assert
      expect(result, equals(Left(ServerFailure())));
    });
  });

  group("updateCustomer", () {
    test("should call 'update' method of data source", () async {
      //arrange
      const customerId = "123";
      Either<Failure, Unit> expected = const Right<Failure, Unit>(unit);
      when(() => mockDS.update(customerId, customerName: "Jim")).thenAnswer((_) async => unit);

      //act
      final result = await customerRepository.updateCustomer(customerId, name: "Jim");

      //assert
      expect(result, equals(expected));
      verify(() => mockDS.update(customerId, customerName: "Jim"));
      verifyNoMoreInteractions(mockDS);
    });

    test("should return Failure when data source throws", () async {
      //arrange
      const customerId = "123";
      when(() => mockDS.update(customerId, customerName: "Jim")).thenThrow(ServerFailure());

      //act
      final result = await customerRepository.updateCustomer(customerId, name: "Jim");

      //assert
      expect(result, equals(Left(ServerFailure())));
    });
  });
}
