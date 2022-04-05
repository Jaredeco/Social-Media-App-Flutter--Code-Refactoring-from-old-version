import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String? id;
  String? text;
  String? uid;
  Timestamp? timeCreated;

  Comment({
    this.id,
    this.text,
    this.uid,
    this.timeCreated,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'uid': uid,
        'timeCreated': timeCreated,
      };
}
