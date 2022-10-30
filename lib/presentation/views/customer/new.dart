import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomerNew extends HookWidget {
  const CustomerNew({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Customer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              debugPrint(nameController.value.text);
              debugPrint(emailController.value.text);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
        ),
      ),
    );
  }
}
