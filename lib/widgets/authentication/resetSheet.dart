import 'package:flutter/material.dart';
import 'package:social_media/constants/theme.dart';
import 'package:social_media/widgets/customWidgets/customText.dart';
import 'package:social_media/widgets/customWidgets/customTextField.dart';
import '../customWidgets/customButton.dart';

Widget resetSheet(Function onT) {
  TextEditingController _email = TextEditingController();
  return ListView(
    physics: NeverScrollableScrollPhysics(),
    children: [
      Container(
        padding: EdgeInsets.only(top: 20, left: 20),
        alignment: Alignment.topLeft,
        child: CustomText(
          text: "Forgot Password?",
          size: 27,
          weight: FontWeight.bold,
          color: AT.nearlyDarkBlue,
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 13, left: 20, right: 20),
        alignment: Alignment.topLeft,
        child: CustomText(
          text:
              "Please, enter your email address. You will receive a link to create a new password via email.",
          size: 15,
          color: Colors.black54,
        ),
      ),
      CustomTextField(
          txtController: _email,
          txtIcon: Icons.email_outlined,
          txtText: "Email"),
      Padding(
          padding: EdgeInsets.all(30),
          child: CustomButton(
              text: "Send",
              bgColor: Colors.blue.shade700,
              onTap: () => onT(_email.text))),
    ],
  );
}
