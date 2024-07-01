import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
   late String? id;
   late String?  name;
   late String?  email;

  UserModel({
     this.id,
     this.name,
     this.email,
  });

  // Factory constructor to create a UserModel from a Firestore document snapshot
  factory UserModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return UserModel(
      id: doc.id,
      name: doc["name"],
      email: doc["email"],
    );
  }

  // Factory constructor to create a UserModel from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

  // Method to convert a UserModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
