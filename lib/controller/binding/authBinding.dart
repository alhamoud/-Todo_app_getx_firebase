 import 'package:get/get.dart';
import 'package:todo_app_getx/controller/authController.dart';

class AuthBinding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<Authcontroller>(() => Authcontroller());
  }
}