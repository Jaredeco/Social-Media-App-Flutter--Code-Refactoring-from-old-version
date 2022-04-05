import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String? id;
  final String? uid;
  final String? postText;
  final String? postImage;
  final int? numberLikes;
  final int? numberComments;
  final Timestamp? timeCreated;
  Post({
    this.id,
    this.uid,
    this.postText,
    this.postImage,
    this.numberLikes,
    this.numberComments,
    this.timeCreated,
  });

  factory Post.fromDocSnapshot(DocumentSnapshot snapshot) {
    return Post(
        id: snapshot.id,
        uid: snapshot["uid"],
        postText: snapshot["postText"],
        postImage: snapshot["postImage"],
        numberLikes: snapshot["numberLikes"],
        numberComments: snapshot["numberComments"],
        timeCreated: snapshot["timeCreated"]);
  }
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'postText': postText,
        'postImage': postImage,
        'numberLikes': numberLikes,
        'numberComments': numberComments,
        'timeCreated': timeCreated,
      };
}
