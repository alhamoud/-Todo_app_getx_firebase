import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_getx/models/todo.dart';
import 'package:todo_app_getx/services/database.dart';


class TodoCard extends StatelessWidget {
  final String uid;
  final TodoModel todo;

  const TodoCard({
    Key? key,
    required this.uid,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
          child: Row(
            children: [
              Expanded(
                child: Text(
                          todo!.content ?? 'No content',
                  style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            ),),
              ),
            Checkbox(
                value: todo!.done,
                onChanged: (newValue){
                  Database().updateTodo(
                      newValue ?? false,
                      uid, todo.todoid);
                })
            ],
          ),
    );
  }
}
