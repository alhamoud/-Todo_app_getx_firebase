import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:todo_app_getx/controller/authController.dart';
import 'package:todo_app_getx/models/todo.dart';
import 'package:todo_app_getx/services/database.dart';

class Todocontroller extends GetxController{
  Rxn<List<TodoModel>> todolist = Rxn<List<TodoModel>>() ;


  List<TodoModel>? get todos => todolist.value ?? [];

  @override
  void onInit() {
    // TODO: implement onInit
    String uid= Get.find<Authcontroller>().user!.uid;
    todolist.bindStream(Database().todoStream(uid));//Stream cominf rom firebase

  }

}