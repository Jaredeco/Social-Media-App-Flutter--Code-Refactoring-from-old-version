import 'package:social_media/constants/firebase.dart';
import 'package:social_media/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:social_media/controllers/challenge_controller.dart';
import 'package:social_media/controllers/post_controller.dart';
import 'package:social_media/controllers/user_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization.then((value) {
    Get.put(AuthController());
    Get.put(UserController());
    Get.put(ChallengeController());
    Get.put(PostController());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'social_media',
      theme: ThemeData(
        fontFamily: 'OpenSans',
        primarySwatch: Colors.purple,
      ),
      home: Splash(),
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}
