import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:social_media/constants/controllers.dart';
import 'package:social_media/constants/firebase.dart';
import 'package:social_media/models/challenge.dart';
// import 'package:social_media/screens/widgets/comment_bottomsheet.dart';

class ChallengeController extends GetxController {
  static ChallengeController instance = Get.find();
  var challenges = <Challenge>[].obs;

  @override
  void onInit() {
    super.onInit();
    challenges.bindStream(loadChallenges());
  }

  loadChallenges() {
    CollectionReference<Map<String, dynamic>> _challengeCollection =
        firebaseFirestore.collection("challenges");
    Stream<QuerySnapshot> _challengeStream =
        _challengeCollection.orderBy("timeCreated").snapshots();

    return _challengeStream.map((qSnap) => qSnap.docs
        .map((docSnap) => Challenge.fromDocSnapshot(docSnap))
        .toList());
  }

  getChalName(String challengeId) async {
    return await firebaseFirestore.collection('challenges').doc(challengeId).get();
  }

  Future<DocumentSnapshot<Object?>> getProfileData(uid) async {
    return await firebaseFirestore.collection('userData').doc(uid).get();
  }

  getChallengeData(String challengeId) async {
    return await firebaseFirestore.collection('challenges').doc(challengeId).get();
  }

  Future<bool> onLikeButtonTapped(String challengeId, String? document) async {
    bool isLiked = false;
    if (document != "comment") {
      final _uid = await authController.getCurrentUID();
      Future<DocumentSnapshot> docSnapshot =
          firebaseFirestore.collection('challenges').doc(challengeId).get();
      DocumentSnapshot doc = await docSnapshot;
      isLiked = doc[document!].contains(_uid);
      if (isLiked) {
        await firebaseFirestore
            .collection('challenges')
            .doc(challengeId)
            .update({
          document: FieldValue.arrayRemove([_uid])
        });
      } else {
        await firebaseFirestore
            .collection('challenges')
            .doc(challengeId)
            .update({
          document: FieldValue.arrayUnion([_uid])
        });
      }
    } else {
      // Get.to(() => CommentPage(challengeId: challengeId));
    }
    return !isLiked;
  }
}
