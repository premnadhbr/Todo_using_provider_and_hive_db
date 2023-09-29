import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_hive_bloc/app/controller/provider.dart';
import 'package:todo_hive_bloc/app/model/todo.dart';
import 'package:todo_hive_bloc/app/view/add_todo.dart';
import 'package:todo_hive_bloc/app/view/update.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HIVE TODO'),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          final todos = todoProvider.todoBox.values.toList();

          if (todos.isEmpty) {
            return Center(
              child: Text('No Data Available'),
            );
          } else {
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                Todo todo = todos[index];
                return ListTile(
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: todo.isComplete ? Colors.green : Colors.black,
                      decoration: todo.isComplete
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  leading: Checkbox(
                    value: todo.isComplete,
                    onChanged: (value) {
                      Todo newTodo = Todo(
                        title: todo.title,
                        isComplete: value!,
                      );
                      todoProvider.updateTodoAt(index, newTodo);
                    },
                  ),
                  trailing: Container(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    UpdateUser(username: todo.title),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            todoProvider.deleteTodoAt(index);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Todo deleted successfully!"),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  tileColor: Colors.lightBlue[100],
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTodo(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
