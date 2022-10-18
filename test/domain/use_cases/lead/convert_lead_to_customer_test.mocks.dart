// Mocks generated by Mockito 5.3.2 from annotations
// in crm/test/domain/use_cases/lead/convert_lead_to_customer_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:crm/core/error/failures.dart' as _i5;
import 'package:crm/domain/model/customer.dart' as _i6;
import 'package:crm/domain/repositories/interfaces/customer_repository.dart'
    as _i3;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [CustomerRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockCustomerRepository extends _i1.Mock
    implements _i3.CustomerRepository {
  MockCustomerRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Customer>>> getAllCustomers(
          _i6.CustomerType? customerType) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllCustomers,
          [customerType],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, List<_i6.Customer>>>.value(
                _FakeEither_0<_i5.Failure, List<_i6.Customer>>(
          this,
          Invocation.method(
            #getAllCustomers,
            [customerType],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.Customer>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Customer>> getCustomer(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCustomer,
          [id],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Customer>>.value(
            _FakeEither_0<_i5.Failure, _i6.Customer>(
          this,
          Invocation.method(
            #getCustomer,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Customer>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>> createCustomer(
          _i6.Customer? data) =>
      (super.noSuchMethod(
        Invocation.method(
          #createCustomer,
          [data],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>>.value(
            _FakeEither_0<_i5.Failure, _i2.Unit>(
          this,
          Invocation.method(
            #createCustomer,
            [data],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>> deleteCustomer(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteCustomer,
          [id],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>>.value(
            _FakeEither_0<_i5.Failure, _i2.Unit>(
          this,
          Invocation.method(
            #deleteCustomer,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>> updateCustomer(
    String? id, {
    String? name,
    String? email,
    _i6.CustomerType? customerType,
    bool? isActive,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateCustomer,
          [id],
          {
            #name: name,
            #email: email,
            #customerType: customerType,
            #isActive: isActive,
          },
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>>.value(
            _FakeEither_0<_i5.Failure, _i2.Unit>(
          this,
          Invocation.method(
            #updateCustomer,
            [id],
            {
              #name: name,
              #email: email,
              #customerType: customerType,
              #isActive: isActive,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>>);
}
