import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:crm/domain/use_cases/customer/delete_customer.dart';
import 'package:crm/domain/use_cases/customer/get_customer.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomerDetailViewModel {
  Customer data;
  String error;
  Function(String id) fetchCustomerData;
  Function(String id) deleteCustomer;
  CustomerDetailViewModel({
    required this.data,
    required this.fetchCustomerData,
    required this.deleteCustomer,
    required this.error,
  });
}

CustomerDetailViewModel useCustomerDetailViewModel({
  required GetCustomer getCustomerUseCase,
  required DeleteCustomer deleteCustomerUseCase,
}) {
  final customer = useState<Customer>(const Customer(id: "", name: "", email: ""));
  final error = useState<String>("");

  void fetchCustomerData(String id) async {
    error.value = "";
    var result = await getCustomerUseCase.execute(id);
    result.fold((failure) {
      if (failure == ServerFailure()) {
        error.value = "Error Fetching Customer!";
      }
    }, (data) {
      customer.value = data;
    });
  }

  void deleteCustomer(String id) async {
    error.value = "";
    var result = await deleteCustomerUseCase.execute(id);
    result.fold((failure) {
      if (failure == ServerFailure()) {
        error.value = "Error Deleting Customer!";
      }
    }, (data) {
      // customer.value = data;
    });
  }

  return CustomerDetailViewModel(
    data: customer.value,
    fetchCustomerData: fetchCustomerData,
    deleteCustomer: deleteCustomer,
    error: error.value,
  );
}
