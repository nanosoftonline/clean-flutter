import 'package:crm/presentation/views/customer/list.dart';
import 'package:crm/presentation/views/models/screen.dart';
import 'package:crm/presentation/views/task/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const CRMApp());
}

class CRMApp extends StatelessWidget {
  const CRMApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
        home: AppContainer(),
      );
}

class AppContainer extends HookWidget {
  AppContainer({super.key});

  final screens = [
    Screen(title: "Customers", widget: const CustomerList(), icon: const Icon(Icons.person)),
    Screen(title: "Tasks", widget: const TaskList(), icon: const Icon(Icons.task)),
  ];

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);
    return Scaffold(
      body: screens.elementAt(selectedIndex.value).widget,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex.value,
        onTap: (index) => selectedIndex.value = index,
        items: screens.map((screen) => BottomNavigationBarItem(icon: screen.icon, label: screen.title)).toList(),
      ),
    );
  }
}
