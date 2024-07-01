import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_getx/controller/authController.dart';
import 'package:todo_app_getx/screens/singup.dart';
class Login extends GetWidget<Authcontroller>{
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Login")),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
          
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(hintText: "Email"),
                  controller: emailController,
                ),
                SizedBox(
                  height: 40,
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Password"),
                  controller: passwordController,
                  obscureText: true,
                ),
                SizedBox(height: 5,),
          
                ElevatedButton(
                  child: Text("Log In"),
                  onPressed: () {
                        controller.login(emailController.text, passwordController.text);
                  },
                ),
                SizedBox(height: 5,),
                ElevatedButton(
          
                  child: Text("Sign Up"),
                  onPressed: () {
                    Get.to(SignUp());
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
