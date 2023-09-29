import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_hive_bloc/app/controller/provider.dart';
import 'package:todo_hive_bloc/app/model/todo.dart';

class UpdateUser extends StatefulWidget {
  final String username;

  UpdateUser({required this.username});

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  late TextEditingController titleController;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the old value
    titleController = TextEditingController(text: widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Todo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final todoProvider = context.read<TodoProvider>();
                final updatedTitle = titleController.text;

                if (updatedTitle.isNotEmpty) {
                  // Create an updatedTodo with the old value
                  final oldTodo =
                      todoProvider.getTodoByUsername(widget.username);
                  final updatedTodo = Todo(
                    title: updatedTitle,
                    isComplete: oldTodo?.isComplete ?? false,
                  );

                  // Use the todoProvider to update the todo
                  todoProvider.updateTodo(widget.username, updatedTodo);

                  Navigator.pop(context);
                }
              },
              child: Text('Update Todo'),
            ),
          ],
        ),
      ),
    );
  }
}
