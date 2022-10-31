import 'package:crm/core/error/failures.dart';
import 'package:crm/domain/model/customer.dart';
import 'package:crm/domain/use_cases/customer/create_customer.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomerNewViewModel {
  Customer data;
  String error;
  Function({required String name, required String email}) saveCustomerData;
  CustomerNewViewModel({
    required this.data,
    required this.saveCustomerData,
    required this.error,
  });
}

CustomerNewViewModel useCustomerNewViewModel({required CreateCustomer createCustomer}) {
  final customer = useState<Customer>(const Customer(id: "", name: "", email: ""));
  final error = useState<String>("");
  void saveCustomerData({required String name, required String email}) async {
    var result = await createCustomer.execute(Customer(name: name, email: email));
    result.fold((failure) {
      if (failure == ServerFailure()) {
        error.value = "Error Saving Customer Data!";
      }
    }, (data) {});
  }

  return CustomerNewViewModel(
    data: customer.value,
    saveCustomerData: saveCustomerData,
    error: error.value,
  );
}
