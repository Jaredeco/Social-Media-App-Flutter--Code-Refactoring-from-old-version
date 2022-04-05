import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_media/constants/firebase.dart';
import 'package:get/get.dart';
import 'package:social_media/models/user_info.dart' as usrin;
import 'package:social_media/screens/introduction_animation/introduction_animation_screen.dart';
import 'package:social_media/widgets/authentication/loadingDialog.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_media/screens/main/home_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  Rx<User>? firebaseUser;
  RxBool isLoggedIn = false.obs;
  RxBool mediaDisplayed = true.obs;
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void onReady() {
    super.onReady();
    auth.userChanges().listen((User? user) {
      if (user == null) {
        Get.offAll(() => const IntroductionAnimationScreen());
      } else {
        Get.offAll(() => const Home(pageIndex: 0),
            transition: Transition.rightToLeft,
            duration: const Duration(seconds: 1, milliseconds: 300));
      }
    });
  }

  getCurrentUID() {
    return auth.currentUser!.uid;
  }

  changeDisplayedAuthWidget(bool social_media) {
    mediaDisplayed.value = social_media;
  }

  void signIn() async {
    try {
      startLoading();
      await auth.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      dismissLoading();
    } on FirebaseAuthException catch (e) {
      dismissLoading();
      Get.snackbar("Sign In Failed", e.message.toString());
    }
  }

  void signUp() async {
    try {
      startLoading();
      await auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        String _uid = result.user!.uid;
        _addUserToDatabase(_uid, email.text.trim());
      });
      dismissLoading();
    } on FirebaseAuthException catch (e) {
      dismissLoading();
      Get.snackbar("Sign Up Failed", e.message.toString());
    }
  }

  void signInWGoogle() async {
    try {
      startLoading();
      GoogleSignInAccount? _account = await _googleSignIn.signIn();
      GoogleSignInAuthentication _googleAuth = await _account!.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);
      String _uid =
          (await auth.signInWithCredential(credential)).user!.uid.toString();
      String _name = (await auth.signInWithCredential(credential))
          .user!
          .displayName
          .toString();
      _addUserToDatabase(_uid, _name);
      dismissLoading();
    } catch (e) {
      dismissLoading();
      Get.snackbar("Sign In Failed", e.toString());
    }
  }

  void signOut() async {
    startLoading();
    auth.signOut();
    dismissLoading();
  }

  _addUserToDatabase(String uid, String name) {
    usrin.UserInfo _newUser = usrin.UserInfo(
        userImage:
            "https://firebasestorage.googleapis.com/v0/b/social-media-io.appspot.com/o/image_picker5724759345753444584.jpg?alt=media&token=6a5d89cd-cf77-4bcb-9423-18df82744479",
        userName: name,
        bio: "",
        uid: uid.toString(),
        completed: [],
        following: [],
        followers: [],
        inProgress: []);
    firebaseFirestore.collection("userData").doc(uid).set(_newUser.toJson());
  }

  void sendResetEmail(String email) async {
    try {
      auth.sendPasswordResetEmail(email: email);
      Get.snackbar("Email sent!",
          "An email with link to reset your password has been sent to your email.");
    } catch (e) {
      Get.snackbar("Failed", e.toString());
    }
  }
}
