# Clean Architecture CRM (Customer relationship management)

In this project, we will explore the process of creating a CRM application using a Clean Architecture way.

Customer Relationship Management (CRM) is a strategy that companies use to manage interactions with customers and potential customers (leads). In this project, we'll store all customer information and activity tasks that we've had with that customer.

We'll implement the following use cases:
### Leads
1. Get all leads
2. Create new lead
3. Convert lead to customer
4. Update lead details

### Customer
2. Get all customers
3. Create customer
4. Update customer details
5. Make customer inactive
6. Delete an existing customer


### Tasks
1. Get all activities for customer
2. Create customer task
   

Clean architecture is a software design philosophy that organizes code in such a way that it encapsulates the business logic but keeps it separate from the implementation.

The aim is to allow the core parts of the application to deal with changing implementations of other parts of the application.

We should be able to change presentation layer parts (UI for web and mobile, Routes for APIs) easily without changing the domain layer parts (use cases and repository or adapter) and data layers (MS SQL, PostgreSQL, MongoDB, etc infrastructure data sources)

Clean Architecture was originally illustrated by Uncle Bob using the following image

![Uncle Bobs Clean Architecture](https://csharpcorner-mindcrackerinc.netdna-ssl.com/article/what-is-clean-architecture/Images/What%20is%20Clean%20Architecture1.png)


Here we see that each onion layer only knows and cares about its immediate inner layer as illustrated by arrows drawn from outer to inner.

A more contextual front-end application illustration of clean architecture would be the following image which illustrates a flow of control and dependencies between different components of the application.

<img src="docs/clean_arch.png"  height="500px"/>

Before we start let's install a few flutter dependencies. We need 
* Equatable for object comparison
* Dio for HTTP calls
* Mockito for mocking dependencies in our tests


Now let's create our piece of code in the form of a customer entity

```dart
//lib/domain/entities/customer.dart
import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  final String id;
  final String name;
  final String email;
  final bool isActive;

  const Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.isActive,
  });

  @override
  List<Object> get props {
    return [id, name, email, isActive];
  }
}
```

 and another entity for customer tasks. 


 ```dart
 //lib/domain/entities/task.dart
 import 'package:crm/domain/entities/customer.dart';

enum Status { notStarted, deferred, inProgress, completed, waitingForInput }

enum Priority { low, normal, high }

class Task {
  final String id;
  final Customer customer;
  final Priority priority;
  final String subject;
  final Status status;
  final DateTime dueDate;

  const Task({
    required this.id,
    required this.customer,
    this.priority = Priority.high,
    this.status = Status.notStarted,
    required this.subject,
    required this.dueDate,
  });
}

 ```


Let's also define an error object that we'll use throughout the application. All functions will either return this failure type or a valid return type. We'll not be throwing exceptions. This will be a more functional programming way of writing functions with no side effects.

```dart
//lib/core/error/failures.dart
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List props = const <dynamic>[]]);
}
```
