import 'package:cloud_firestore/cloud_firestore.dart';

class Challenge {
    String? imageVal; 
    String? taskName;
    String? description;
    String? uid;
    String? id;
    Timestamp? timeCreated;
    List? likedBy;
    List? dislikedBy;
    List? completedBy;
    List? comments;


  Challenge({
      this.imageVal,
      this.taskName,
      this.description,
      this.uid,
      this.id,
      this.timeCreated,
      this.likedBy,
      this.dislikedBy,
      this.completedBy,
      this.comments,
  });

  factory Challenge.fromDocSnapshot(DocumentSnapshot snapshot) {
    return Challenge(
        id: snapshot.id,
        imageVal: snapshot["imageVal"],
        taskName: snapshot["taskName"],
        description: snapshot["description"],
        likedBy: snapshot["likedBy"],
        dislikedBy: snapshot["dislikedBy"],
        completedBy: snapshot["completedBy"],
        comments: snapshot["comments"],
        uid: snapshot["uid"],
        timeCreated: snapshot["timeCreated"],
        );
  }

  Map<String, dynamic> toJson() => {
    'imageVal':imageVal,
    'taskName':taskName,
    'description':description,
    'likedBy':likedBy,
    'dislikedBy':dislikedBy,
    'completedBy':completedBy,
    'comments':comments,
    'uid':uid,
    'timeCreated':timeCreated,
  };
}
