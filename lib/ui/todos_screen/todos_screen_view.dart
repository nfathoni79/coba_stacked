import 'package:coba_stacked/ui/todos_screen/todos_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TodosScreenView extends StatelessWidget {
  const TodosScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TodosScreenViewModel>.reactive(
      viewModelBuilder: () => TodosScreenViewModel(),
      builder: (context, vm, _) => Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Stacked Todos'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            // Show empty text if there is no Todo
            if (vm.todos.isEmpty)
              const Opacity(
                opacity: 0.5,
                child: Column(
                  children: [
                    SizedBox(height: 64),
                    Icon(
                      Icons.emoji_food_beverage_outlined,
                      size: 48,
                    ),
                    SizedBox(height: 16),
                    Text('No todos yet. Click + to add a new one.'),
                  ],
                ),
              ),

            // Map Todos to list of ListTile
            ...vm.todos.map((todo) {
              return ListTile(
                leading: IconButton(
                  icon: Icon(
                    todo.completed ? Icons.task_alt : Icons.circle_outlined,
                  ),
                  onPressed: () => vm.toggleTodoStatus(todo.id),
                ),
                title: TextField(
                  controller: TextEditingController(text: todo.content),
                  // null decoration: no input line
                  decoration: null,
                  focusNode: vm.getFocusNode(todo.id),
                  // null maxLines: infinite lines
                  maxLines: null,
                  onChanged: (text) => vm.updateTodoContent(todo.id, text),
                  style: TextStyle(
                    fontSize: 20,
                    decoration:
                        todo.completed ? TextDecoration.lineThrough : null,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.horizontal_rule),
                  onPressed: () => vm.removeTodo(todo.id),
                ),
              );
            }),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: vm.createNewTodo,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
