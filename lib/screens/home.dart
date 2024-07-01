import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:todo_app_getx/controller/authController.dart';
import 'package:todo_app_getx/controller/todocontroller.dart';
import 'package:todo_app_getx/controller/usercontroller.dart';
import 'package:todo_app_getx/services/database.dart';
import 'package:todo_app_getx/widgets/todo_card.dart';

class Home extends GetWidget<Authcontroller> {
  final TextEditingController _todoController = TextEditingController();
  final Todocontroller todocontroller = Get.put(Todocontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: GetX<Usercontroller>(
          init: Get.put(Usercontroller()),
          initState: (_) async {
            Get.find<Usercontroller>().user =
                await Database().getUser(controller.user!.uid);
          },
          builder: (_) {
            String userName = _.user.name ?? "No user Name";
            return Text(
                userName.isNotEmpty ? "Welcome $userName" : "Loading...");
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              controller.signOut();
            },
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              if (Get.isDarkMode) {
                Get.changeTheme(ThemeData.light());
              } else {
                Get.changeTheme(ThemeData.dark());
              }
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Text(
            "Add Todo Here:",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Card(
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _todoController,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (_todoController != null) {
                          Database().addTodo(
                              _todoController.text, controller.user!.uid);
                          print(_todoController.text);
                          print(controller.user!.uid);
                          _todoController.clear();
                        }
                      },
                      icon: Icon(Icons.add))
                ],
              ),
            ),
          ),
          Text(
            "Your Todos ${todocontroller.todos?.length}",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          GetX<Todocontroller>(
              init: Get.put<Todocontroller>(Todocontroller()),
              builder: (Todocontroller todocontroller) {
                if (todocontroller != null && todocontroller.todos != null) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: todocontroller.todos?.length,
                        itemBuilder: (_, index) {
                          return TodoCard(
                            uid: controller.user!.uid,
                            todo: todocontroller.todos![index],
                          );
                        }),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })
        ],
      ),
    );
  }
}
