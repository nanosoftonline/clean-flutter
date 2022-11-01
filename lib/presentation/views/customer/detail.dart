import 'package:crm/data/data_sources/implementations/api/customer_datasource_impl.dart';
import 'package:crm/domain/repositories/implementations/customer_repository_impl.dart';
import 'package:crm/domain/use_cases/customer/delete_customer.dart';
import 'package:crm/domain/use_cases/customer/get_customer.dart';
import 'package:crm/presentation/view_models/customer/detail.dart';
import 'package:crm/presentation/views/customer/edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomerDetail extends HookWidget {
  const CustomerDetail(this.id, {super.key});
  final String id;

  @override
  Widget build(BuildContext context) {
    final vm = useCustomerDetailViewModel(
      getCustomerUseCase: GetCustomerImpl(CustomerRepositoryImpl(CustomerDataSourceImpl())),
      deleteCustomerUseCase: DeleteCustomerImpl(CustomerRepositoryImpl(CustomerDataSourceImpl())),
    );

    useEffect(() {
      vm.fetchCustomerData(id);
      return () {};
    }, []);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Customer Edit'),
          actions: [
            TextButton(
              child: const Text("Edit"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomerEdit(vm.data.id!)),
                ).then((value) {
                  vm.fetchCustomerData(id);
                });
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(vm.data.name),
              ),
              ListTile(
                title: Text(vm.data.email),
              ),
              SwitchListTile(
                title: const Text("Active"),
                value: vm.data.isActive,
                onChanged: (value) {},
              ),
              OutlinedButton(
                onPressed: () {
                  vm.deleteCustomer(vm.data.id!);
                  Navigator.pop(context);
                },
                child: const Text('Delete'),
              )
            ],
          ),
        ));
  }
}
