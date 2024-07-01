import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_getx/controller/authController.dart';
import 'package:todo_app_getx/controller/usercontroller.dart';
import 'package:todo_app_getx/screens/home.dart';
import 'package:todo_app_getx/screens/login.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize Authcontroller and Usercontroller

    return GetX<Authcontroller>(

      builder: (authController) {
        if (authController.user?.uid != null) {
          // User is authenticated, show Home screen
          return Home();
        } else {
          // User is not authenticated, show Login screen
          return Login();
        }
      },
    );
  }
}

// Obx(() {
// return Get.find<Authcontroller>().user !=null ? Home(): Login() ;
//
// }
// );