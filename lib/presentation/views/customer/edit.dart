import 'package:crm/data/data_sources/implementations/api/customer_datasource_impl.dart';
import 'package:crm/domain/repositories/implementations/customer_repository_impl.dart';
import 'package:crm/domain/use_cases/customer/get_all_customers.dart';
import 'package:crm/domain/use_cases/customer/get_customer.dart';
import 'package:crm/domain/use_cases/customer/update_customer_details.dart';
import 'package:crm/presentation/view_models/customer/edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomerEdit extends HookWidget {
  const CustomerEdit(this.id, {super.key});
  final String id;

  @override
  Widget build(BuildContext context) {
    final vm = useCustomerEditViewModel(
      getCustomer: GetCustomerImpl(CustomerRepositoryImpl(CustomerDataSourceImpl())),
      updateCustomer: UpdateCustomerImpl(CustomerRepositoryImpl(CustomerDataSourceImpl())),
    );
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final isActive = useState(false);

    useEffect(() {
      vm.fetchCustomerData(id);
      return () {};
    }, []);

    useEffect(() {
      nameController.text = vm.data.name;
      emailController.text = vm.data.email;
      isActive.value = vm.data.isActive;
      return () {};
    }, [vm.data.id]);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Customer Edit'),
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                vm.saveCustomerData(
                  name: nameController.text,
                  email: emailController.text,
                  isActive: isActive.value,
                );
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(controller: nameController),
              TextField(controller: emailController),
              SwitchListTile(
                title: const Text("Active"),
                value: isActive.value,
                onChanged: (value) {
                  isActive.value = value;
                },
              )
            ],
          ),
        ));
  }
}
