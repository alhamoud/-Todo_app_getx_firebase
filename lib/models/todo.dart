import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String todoid;
  String content;
  Timestamp dataCreated;
  bool done;

  TodoModel({
    required this.todoid,
    required this.content,
    required this.done,
    required this.dataCreated,
  });

  TodoModel.fromDocumentSnapshot(DocumentSnapshot doc)
      : todoid = doc.id,
        content = doc["content"] as String? ?? '',
        dataCreated = doc["dataCreated"] as Timestamp? ?? Timestamp.now(),
        done = doc["done"] as bool? ?? false;
}