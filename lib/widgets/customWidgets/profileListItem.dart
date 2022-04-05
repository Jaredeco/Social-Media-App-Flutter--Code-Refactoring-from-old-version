import 'package:flutter/material.dart';
import 'package:social_media/constants/theme.dart';

class ProfileListItem extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final bool hasNavigation;
  final AnimationController? animationController;
  final Animation<double>? animation;

  const ProfileListItem(
      {Key? key,
      this.icon,
      this.text,
      this.hasNavigation = true,
      this.animationController,
      this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: AT.nearlyDarkBlue,
                borderRadius: BorderRadius.circular(AT.kSpacingUnit * 3),
                gradient: LinearGradient(colors: [
                  AT.nearlyDarkBlue,
                  HexColor('#6A88E5'),
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              height: AT.kSpacingUnit * 5.5,
              margin: EdgeInsets.symmetric(
                horizontal: AT.kSpacingUnit * 4,
              ).copyWith(
                bottom: AT.kSpacingUnit * 2,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: AT.kSpacingUnit * 2,
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    this.icon,
                    size: AT.kSpacingUnit * 2.5,
                  ),
                  SizedBox(width: AT.kSpacingUnit * 1.5),
                  Text(
                    this.text!,
                  ),
                  Spacer(),
                  if (this.hasNavigation)
                    Icon(
                      Icons.arrow_right_alt_rounded,
                      color: Colors.white,
                      size: AT.kSpacingUnit * 2.5,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
