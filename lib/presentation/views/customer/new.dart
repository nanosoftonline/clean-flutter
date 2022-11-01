import 'package:crm/data/data_sources/implementations/api/customer_datasource_impl.dart';
import 'package:crm/domain/repositories/implementations/customer_repository_impl.dart';
import 'package:crm/domain/use_cases/customer/create_customer.dart';
import 'package:crm/presentation/view_models/customer/new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomerNew extends HookWidget {
  const CustomerNew({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = useCustomerNewViewModel(
      createCustomer: CreateCustomerImpl(CustomerRepositoryImpl(CustomerDataSourceImpl())),
    );
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Customer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              vm.saveCustomerData(name: nameController.text, email: emailController.text);
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: vm.error.isEmpty ? buildList(nameController, emailController) : buildError(vm)),
    );
  }

  Center buildError(CustomerNewViewModel vm) {
    return Center(
      child: Text(vm.error),
    );
  }

  Column buildList(TextEditingController nameController, TextEditingController emailController) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(hintText: "Name"),
          controller: nameController,
        ),
        TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(hintText: "Email"),
          controller: emailController,
        )
      ],
    );
  }
}
