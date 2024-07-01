import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:todo_app_getx/controller/usercontroller.dart';
import 'package:todo_app_getx/models/user.dart';

import '../services/database.dart';

class Authcontroller extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> _firebaseUser = Rxn<User>();

  User? get user => _firebaseUser.value;

  @override
  void onInit() {
    super.onInit();

    _firebaseUser.bindStream(_auth.authStateChanges());
  }

  void createUser(String name , String email, String password) async {
    try {
      UserCredential _authResult  = await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
      UserModel _user = UserModel(
        id: _authResult.user?.uid,
        name: name,
          email: _authResult.user?.email);
        if(  await Database().createNewUser(_user)){
          //user created successfully
          Get.find<Usercontroller>().user = _user;
          Get.back();
        }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error Creating account", e.message ?? 'Unknown error', snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void login(String email, String password)  async {
    try {
      UserCredential _authResult= await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
      Get.find<Usercontroller>().user = await Database().getUser(_authResult.user!.uid);

    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error Logging in", e.message ?? 'Unknown error', snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
      Get.find<Usercontroller>().clear();
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error Signing out", e.message ?? 'Unknown error', snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}
