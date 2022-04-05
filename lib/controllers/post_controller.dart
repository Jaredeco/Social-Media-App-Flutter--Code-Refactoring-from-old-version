import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:social_media/constants/firebase.dart';
import 'package:social_media/models/post.dart';

class PostController extends GetxController {
  static PostController instance = Get.find();

  var posts = <Post>[].obs;

  @override
  void onInit() {
    super.onInit();
    posts.bindStream(loadPosts());
  }

  loadPosts() {
    CollectionReference<Map<String, dynamic>> _postsCollection =
        firebaseFirestore.collection("posts");
    Stream<QuerySnapshot> _postStream =
        _postsCollection.orderBy("timeCreated").snapshots();

    return _postStream.map((qSnap) =>
        qSnap.docs.map((docSnap) => Post.fromDocSnapshot(docSnap)).toList());
  }
}
