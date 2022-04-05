import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfo {
  final String? userImage;
  final String? userName;
  final String? bio;
  final String? uid;
  final List? completed;
  final List? inProgress;
  final List? followers;
  final List? following;
  UserInfo({
    this.userImage,
    this.userName,
    this.bio,
    this.uid,
    this.completed,
    this.inProgress,
    this.followers,
    this.following,
  });

  factory UserInfo.fromDocSnapshot(DocumentSnapshot snapshot) {
    return UserInfo(
        uid: snapshot.id,
        userImage: snapshot["userImage"],
        userName: snapshot["userName"],
        bio: snapshot["bio"],
        completed: snapshot["completed"],
        followers: snapshot["followers"],
        following: snapshot["following"],
        inProgress: snapshot["inProgress"]);
  }

  Map<String, dynamic> toJson() => {
        'userImage': userImage,
        'userName': userName,
        'bio': bio,
        'uid': uid,
        'completed': completed,
        'followers': followers,
        'following': following,
        'inProgress': inProgress,
      };
}
