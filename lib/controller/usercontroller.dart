import 'package:get/get.dart';
import 'package:todo_app_getx/models/user.dart';
class Usercontroller extends GetxController{
  Rx<UserModel> _userModel = UserModel().obs;

 UserModel get user => _userModel.value;

 set user(UserModel value) => this._userModel.value = value;

 void clear(){
   _userModel.value= UserModel();
 }
}