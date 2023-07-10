import 'dart:math';

import 'package:coba_stacked/models/todo.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';

class TodosService with ListenableServiceMixin {
  TodosService() {
    listenToReactiveValues([_todos]);
  }

  // cast<T>() casts Hive value to List<T>
  final _todos = ReactiveValue<List<Todo>>(
    Hive.box('todos').get('todos', defaultValue: []).cast<Todo>(),
  );

  final _random = Random();

  List<Todo> get todos => _todos.value;

  /// Generate random 10 characters string.
  String _generateId() {
    return String.fromCharCodes(
      List.generate(10, (_) => _random.nextInt(33) + 80),
    );
  }

  void _saveToHive() => Hive.box('todos').put('todos', _todos.value);

  void createNewTodo() {
    // Insert in the beginning.
    _todos.value.insert(0, Todo(id: _generateId()));

    _saveToHive();
    notifyListeners();
  }

  bool removeTodo(String id) {
    final index = _todos.value.indexWhere((todo) => todo.id == id);

    if (index != -1) {
      _todos.value.removeAt(index);
      _saveToHive();
      notifyListeners();

      return true;
    } else {
      return false;
    }
  }

  bool toggleTodoStatus(String id) {
    final index = _todos.value.indexWhere((todo) => todo.id == id);

    if (index != -1) {
      _todos.value[index].completed = !_todos.value[index].completed;
      _saveToHive();
      notifyListeners();

      return true;
    } else {
      return false;
    }
  }

  bool updateTodoContent(String id, String text) {
    final index = _todos.value.indexWhere((todo) => todo.id == id);

    if (index != -1) {
      _todos.value[index].content = text;
      _saveToHive();

      // No notifyListeners() to prevent cursor from jumping each time we type.

      return true;
    } else {
      return false;
    }
  }
}
