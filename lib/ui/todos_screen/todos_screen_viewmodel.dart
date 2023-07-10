import 'package:coba_stacked/app/locator.dart';
import 'package:coba_stacked/models/todo.dart';
import 'package:coba_stacked/services/todos_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TodosScreenViewModel extends ReactiveViewModel {
  final _todosService = locator<TodosService>();
  final _firstTodoFocusNode = FocusNode();

  late final removeTodo = _todosService.removeTodo;
  late final toggleTodoStatus = _todosService.toggleTodoStatus;
  late final updateTodoContent = _todosService.updateTodoContent;

  List<Todo> get todos => _todosService.todos;

  void createNewTodo() {
    _todosService.createNewTodo();
    _firstTodoFocusNode.requestFocus();
  }

  /// Focus input if the Todo is first (after calling requestFocus()).
  FocusNode? getFocusNode(String id) {
    final index = todos.indexWhere((todo) => todo.id == id);
    return index == 0 ? _firstTodoFocusNode : null;
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_todosService];
}