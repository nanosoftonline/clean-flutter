import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:crm/domain/use_cases/customer/get_customer.dart';
import 'package:crm/domain/use_cases/customer/update_customer_details.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomerEditViewModel {
  Customer data;
  String error;
  Function(String id) fetchCustomerData;
  Function({String name, String? email, bool? isActive}) saveCustomerData;
  CustomerEditViewModel({
    required this.data,
    required this.fetchCustomerData,
    required this.error,
    required this.saveCustomerData,
  });
}

CustomerEditViewModel useCustomerEditViewModel({
  required GetCustomer getCustomer,
  required UpdateCustomer updateCustomer,
}) {
  final customer = useState<Customer>(const Customer(id: "", name: "", email: ""));
  final error = useState<String>("");

  void fetchCustomerData(String id) async {
    var result = await getCustomer.execute(id);
    result.fold((failure) {
      if (failure == ServerFailure()) {
        error.value = "Error Fetching Customer!";
      }
    }, (data) {
      customer.value = data;
    });
  }

  void saveCustomerData({String? name, String? email, bool? isActive}) async {
    var result = await updateCustomer.execute(
      customer.value.id,
      name: name != customer.value.name ? name : null,
      email: email != customer.value.email ? email : null,
      isActive: isActive != customer.value.isActive ? isActive : null,
    );
    result.fold((failure) {
      if (failure == ServerFailure()) {
        error.value = "Error Saving Customer Data!";
      }
    }, (data) {});
  }

  return CustomerEditViewModel(
      fetchCustomerData: (String id) {
        fetchCustomerData(id);
      },
      saveCustomerData: saveCustomerData,
      data: customer.value,
      error: error.value);
}
