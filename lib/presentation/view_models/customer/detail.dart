import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:crm/domain/use_cases/customer/get_customer.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomerDetailViewModel {
  Customer data;
  String error;
  Function(String id) fetchCustomerData;
  CustomerDetailViewModel({
    required this.data,
    required this.fetchCustomerData,
    required this.error,
  });
}

CustomerDetailViewModel useCustomerDetailViewModel({required GetCustomer getCustomer}) {
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

  return CustomerDetailViewModel(
    data: customer.value,
    fetchCustomerData: fetchCustomerData,
    error: error.value,
  );
}
