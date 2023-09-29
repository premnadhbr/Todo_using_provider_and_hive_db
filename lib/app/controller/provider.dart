import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_hive_bloc/app/model/todo.dart';

class TodoProvider extends ChangeNotifier {
  final Box<Todo> todoBox = Hive.box<Todo>('todo');

  void addTodo(Todo todo) {
    todoBox.add(todo);
    notifyListeners();
  }

  void updateTodoAt(int index, Todo updatedTodo) {
    todoBox.putAt(index, updatedTodo);
    notifyListeners();
  }

  void deleteTodoAt(int index) {
    todoBox.deleteAt(index);
    notifyListeners();
  }

  void updateTodo(String username, Todo updatedTodo) {
    for (int index = 0; index < todoBox.length; index++) {
      Todo todo = todoBox.getAt(index)!;
      if (todo.title == username) {
        todoBox.putAt(index, updatedTodo);
        notifyListeners();
        break;
      }
    }
  }
}
