import 'package:crm/data/data_sources/implementations/api/customer_datasource_impl.dart';
import 'package:crm/domain/repositories/implementations/customer_repository_impl.dart';
import 'package:crm/domain/use_cases/customer/get_all_customers.dart';
import 'package:crm/presentation/view_models/customer/list.dart';
import 'package:crm/presentation/views/customer/edit.dart';
import 'package:crm/presentation/views/customer/new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomerList extends HookWidget {
  const CustomerList({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = useCustomerListViewModel(
      getAllCustomers: GetAllCustomersImpl(CustomerRepositoryImpl(CustomerDataSourceImpl())),
    );

    useEffect(() {
      vm.fetchData();
      return () {};
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CustomerNew()),
              );
            },
          )
        ],
      ),
      body: vm.error.isNotEmpty
          ? Center(
              child: Text(
              vm.error,
              style: const TextStyle(color: Colors.redAccent),
            ))
          : ListView.builder(
              itemCount: vm.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CustomerEdit(vm.data[index].id)),
                      ).then((value) {
                        vm.fetchData();
                      });
                    },
                    title: Text(vm.data[index].name));
              },
            ),
    );
  }
}
