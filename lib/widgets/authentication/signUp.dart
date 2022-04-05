import 'package:social_media/widgets/authentication/orDivider.dart';
import 'package:social_media/widgets/customWidgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:social_media/constants/controllers.dart';
import 'package:auth_buttons/auth_buttons.dart';
import '../customWidgets/customTextField.dart';

class RegistrationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Column(
        children: [
          CustomTextField(
              txtController: authController.userName,
              txtIcon: Icons.person,
              txtText: "User Name"),
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
            padding: const EdgeInsets.all(25),
            child: CustomButton(
                bgColor: Colors.blue.shade700,
                text: "Sign Up",
                onTap: () {
                  authController.signUp();
                }),
          ),
          OrDivider(),
          Container(
            child: Center(
              child: GoogleAuthButton(onPressed: () {
                authController.signInWGoogle();
              }),
            ),
          ),

        ],
      );
  }
}
