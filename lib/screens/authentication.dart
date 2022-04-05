import 'package:social_media/controllers/auth_controller.dart';
import 'package:social_media/widgets/authentication/bottomText.dart';
import 'package:social_media/widgets/authentication/login.dart';
import 'package:social_media/widgets/authentication/signUp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationScreen extends StatelessWidget {
  final AuthController _authController = Get.find();

  AuthenticationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() => SingleChildScrollView(
          child: Stack(
            children: [
              // Image.asset(
              //   bg,
              //   width: double.infinity,
              //   height: Get.height,
              //   fit: BoxFit.cover,
              // ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: Get.height*0.3),
                  Visibility(
                      visible: _authController.mediaDisplayed.value,
                      child: social_mediaWidget()),
                  Visibility(
                      visible: !_authController.mediaDisplayed.value,
                      child: RegistrationWidget()),
                   const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: _authController.mediaDisplayed.value,
                    child: BottomTextWidget(
                      onTap: () {
                        _authController.changeDisplayedAuthWidget(!_authController.mediaDisplayed.value);
                      },
                      text1: "Don\'t have an account?",
                      text2: "Create account!",
                    ),
                  ),
                  Visibility(
                    visible: !_authController.mediaDisplayed.value,
                    child: BottomTextWidget(
                      onTap: () {
                        _authController.changeDisplayedAuthWidget(!_authController.mediaDisplayed.value);
                      },
                      text1: "Already have an account?",
                      text2: "Sign in!",
                    ),
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ],
          ),
        ),)
    );
  }
}