import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_hive_bloc/app/controller/provider.dart';
import 'package:todo_hive_bloc/app/model/todo.dart';

class AddTodo extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
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
                String title = titleController.text;
                if (title.isNotEmpty) {
                  Todo newTodo = Todo(title: title, isComplete: false);
                  Provider.of<TodoProvider>(context, listen: false)
                      .addTodo(newTodo);
                  Navigator.pop(context);
                }
              },
              child: Text('Add Todo'),
            ),
          ],
        ),
      ),
    );
  }
}
