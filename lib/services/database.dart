import "package:cloud_firestore/cloud_firestore.dart";
import"package:firebase_core/firebase_core.dart";
import "package:todo_app_getx/controller/authController.dart";
import "package:todo_app_getx/controller/todocontroller.dart";
import "package:todo_app_getx/models/todo.dart";
import "package:todo_app_getx/models/user.dart";
import 'package:get/get.dart';

class Database{
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

 Future<bool> createNewUser(UserModel user)async{
  try{
    await _firestore.collection("users").doc(user.id).set({
      "name":user.name,
      "email":user.email
    });
    return true;
  }catch(e){
    print(e);
    return false;
  }
}

Future<UserModel> getUser(String uid)async{
   try{
    DocumentSnapshot doc = await _firestore.collection("users").doc(uid).get();
     return UserModel.fromDocumentSnapshot(doc);
   }catch(e){

     print(e);
     rethrow;}
}

Future<void> addTodo(String content, String uid)async{
   try{
     await   _firestore
         .collection("users")
         .doc(uid)
         .collection("todos")
         .add({
      "dataCreated": Timestamp.now(),
      'content': content,
      'done': false
     });


   }catch(e){
     print(e);
    rethrow;
   }
}

Stream<List<TodoModel>> todoStream (String uid){
return _firestore
    .collection("users")
    .doc(uid)
    .collection("todos")
    .snapshots()
    .map((QuerySnapshot query) {
       List<TodoModel> retVal = [];
       query.docs.forEach((element) {
         retVal.add(TodoModel.fromDocumentSnapshot(element));
       });
       return retVal;
});


}
Future<void> updateTodo( bool newValue, String uid, String todoid)async{
try{
  _firestore
      .collection("users")
      .doc(uid)
      .collection("todos")
      .doc(todoid)
      .update({"done": newValue});
}catch(e){
  print(e);
  rethrow;
}
}
}
