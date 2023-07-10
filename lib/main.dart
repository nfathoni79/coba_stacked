import 'package:coba_stacked/app/locator.dart';
import 'package:coba_stacked/models/todo_adapter.dart';
import 'package:coba_stacked/ui/todos_screen/todos_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox('todos');

  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const TodosScreenView(),
      theme: ThemeData.dark(useMaterial3: true),
      title: 'Flutter Stacked Todos',
    );
  }
}