import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/constants/theme.dart';
import 'package:social_media/widgets/customWidgets/customText.dart';

class SplashView extends StatefulWidget {
  final AnimationController animationController;

  const SplashView({Key? key, required this.animationController})
      : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    final _introductionanimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(0.0, -1.0))
            .animate(CurvedAnimation(
      parent: widget.animationController,
      curve: Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    return SlideTransition(
      position: _introductionanimation,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: Get.width,
              child: Image.asset(
                'assets/images/welcome.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: CustomText(
                text:"Clearhead",
                size: 26,
                color: AT.nearlyDarkBlue,
                weight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 64, right: 64),
              child: CustomText(
                text: "Welcome to my app. I hope you like it. Please enjoy!",
                color: AT.lightText,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 48,
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 16),
              child: InkWell(
                onTap: () {
                  widget.animationController.animateTo(0.2);
                },
                child: Container(
                  height: 58,
                  padding: EdgeInsets.only(
                    left: 56.0,
                    right: 56.0,
                    top: 16,
                    bottom: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(38.0),
                    color: AT.nearlyDarkBlue,
                    gradient: LinearGradient(
                        colors: [
                          AT.nearlyDarkBlue,
                          HexColor('#6A88E5'),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                  ),
                  child: Text(
                    "Let's begin",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
