import 'package:social_media/widgets/authentication/bottomText.dart';
import 'package:social_media/widgets/authentication/orDivider.dart';
import 'package:social_media/widgets/customWidgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:social_media/constants/controllers.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:get/get.dart';
import 'package:social_media/widgets/customWidgets/customTextField.dart';
import 'package:social_media/widgets/authentication/resetSheet.dart';

class social_mediaWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
            txtController: authController.email,
            txtIcon: Icons.email_outlined,
            txtText: "Email"),
        CustomTextField(
            txtController: authController.password,
            txtIcon: Icons.lock,
            txtText: "Password",
            isObscure: true),
        Padding(
          padding: EdgeInsets.all(25),
          child: CustomButton(
              bgColor: Colors.blue.shade700,
              text: "Sign In",
              onTap: () {
                authController.signIn();
                // Get.to(HomeScreen());
              }),
        ),
        OrDivider(),
        Container(
          padding: EdgeInsets.only(bottom: 25),
          child: Center(
            child: GoogleAuthButton(onPressed: () {
              authController.signInWGoogle();
            },),
          ),
        ),
        Center(
          child: BottomTextWidget(
            onTap: () => Get.bottomSheet(
              resetSheet(authController.sendResetEmail),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            text2: "Forgot password?",
          ),
        ),
      ],
    );
  }
}
