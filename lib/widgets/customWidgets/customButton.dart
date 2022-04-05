import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'customText.dart';
import 'package:social_media/constants/theme.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Color? txtColor;
  final Color? bgColor;
  final Color? shadowColor;
  final VoidCallback? onTap;

  const CustomButton(
      {Key? key,
        required this.text,
        this.txtColor,
        this.bgColor,
        this.shadowColor,
        required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: PhysicalModel(
        color: Colors.grey.withOpacity(.4),
        elevation: 5,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: Get.width / 1.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: AT.nearlyDarkBlue,
              gradient: LinearGradient(
                  colors: [
                    AT.nearlyDarkBlue,
                    HexColor('#6A88E5'),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            child: Container(
              margin: EdgeInsets.all(14),
              alignment: Alignment.center,
              child: CustomText(
                text: text!,
                color: txtColor ?? Colors.white,
                size: 22,
                weight: FontWeight.normal,
              ),
            )
        ),
      ),
    );
  }
}