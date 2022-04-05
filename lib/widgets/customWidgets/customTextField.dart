import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/constants/theme.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController txtController;
  final IconData txtIcon;
  final String txtText;
  final bool? isObscure;

  const CustomTextField(
      {Key? key,
      required this.txtController,
      required this.txtIcon,
      required this.txtText,
      this.isObscure})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: Get.width / 1.2,
          margin: EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Color(0xFFF1E6FF),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: TextField(
              obscureText: this.isObscure ?? false,
              controller: this.txtController,
              decoration: InputDecoration(
                  icon: Icon(this.txtIcon, color: AT.nearlyDarkBlue,),
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  hintText: this.txtText, hintStyle: TextStyle(color: AT.nearlyDarkBlue)),
            ),
          ),
        ),
      ],
    );
  }
}
