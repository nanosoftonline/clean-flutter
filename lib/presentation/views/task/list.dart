import 'package:crm/presentation/view_models/another_vm/custom_hook.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TaskList extends HookWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = useCounter(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              vm.increment(5);
            },
          )
        ],
      ),
      body: Center(
        child: Text(vm.counter.toString()),
      ),
    );
  }
}
