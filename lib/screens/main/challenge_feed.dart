import 'package:get/get.dart';
import 'package:social_media/constants/controllers.dart';
import 'package:social_media/controllers/challenge_controller.dart';
import 'package:social_media/screens/main/create_screens/create_challenge.dart';
import 'package:flutter/material.dart';
import 'package:social_media/screens/widgets/app_bar.dart';
import 'package:social_media/screens/widgets/challengeCard.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.add,
              color: Colors.blue[800],
            ),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CreateTask()));
            }),
        appBar: topAppBar(),
        body: GetX<ChallengeController>(builder: (ChallengeController chc) {
          if (chc != null && chc.challenges != null) {
            return ListView(
                children: chc.challenges
                    .map((item) => ChallengeCard(challenge: item))
                    .toList()
                    .cast<Widget>());
          } else {
            return Container();
          }
        }));
  }
}
