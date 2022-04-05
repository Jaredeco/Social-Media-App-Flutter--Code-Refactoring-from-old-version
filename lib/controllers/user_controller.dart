import 'package:get/get.dart';
import 'package:social_media/constants/firebase.dart';
import 'package:social_media/models/user_info.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();

  getProfileData(String uid) async {
    return UserInfo.fromDocSnapshot(
        await firebaseFirestore.collection('userData').doc(uid).get());
  }
}
