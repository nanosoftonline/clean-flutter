import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CounterModel {
  int counter;
  Function(int incrAmount) increment;
  CounterModel({
    required this.counter,
    required this.increment,
  });
}

class CounterHook extends Hook<CounterModel> {
  @override
  HookState<CounterModel, Hook<CounterModel>> createState() {
    return CounterHookState();
  }
}

class CounterHookState extends HookState<CounterModel, CounterHook> {
  int counter = 0;

  @override
  void initHook() {
    setState(() {
      counter = 0;
    });
    super.initHook();
  }

  void increment(int incrAmount) {
    setState(() {
      counter = counter + incrAmount;
    });
  }

  @override
  CounterModel build(BuildContext context) {
    return CounterModel(counter: counter, increment: increment);
  }
}

CounterModel useCounter(BuildContext context) {
  return use(CounterHook());
}
