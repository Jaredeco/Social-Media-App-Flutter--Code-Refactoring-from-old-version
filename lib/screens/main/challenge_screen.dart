import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:social_media/constants/controllers.dart';
import 'package:social_media/constants/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:social_media/models/challenge.dart';
import 'package:social_media/models/user_info.dart';
import 'package:social_media/screens/main/user_profile.dart';

class ChallengePage extends StatefulWidget {
  final Challenge challenge;
  const ChallengePage({Key? key, required this.challenge}) : super(key: key);

  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          widget.challenge!.taskName!,
          style: TextStyle(color: Colors.blue[800]),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.blue[800]),
            onPressed: () => Navigator.of(context).pop()),
      ),
      body: FutureBuilder<DocumentSnapshot>(
          future: challengeController.getProfileData(widget.challenge!.uid),
          builder: (_, snapshot) {
            UserInfo userInfo = UserInfo.fromDocSnapshot(snapshot.data!);
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView(
                children: [
                  Container(
                    height: 270,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(widget.challenge!.imageVal!),
                            fit: BoxFit.cover)),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 20, right: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.challenge!.taskName!,
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: () async {
                              final _currUID =
                                  await authController.getCurrentUID();
                              if (userInfo.uid != _currUID) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        UserProfile(profileId: userInfo.uid)));
                              } else {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => const MyProfile()));
                              }
                            },
                            child: CachedNetworkImage(
                              imageUrl: userInfo.userImage!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: 80.0,
                                height: 80.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              placeholder: (context, url) => Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  border: Border.all(color: Colors.grey),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        InkWell(
                          onTap: () async {
                            final _currUID =
                                await authController.getCurrentUID();
                            if (userInfo.uid != _currUID) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      UserProfile(profileId: userInfo.uid)));
                            } else {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => const MyProfile()));
                            }
                          },
                          child: Text(
                            userInfo.userName!,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            widget.challenge!.description!,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      LikeButton(
                        likeCount: widget.challenge!.likedBy!.length,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ButtonTheme(
                      minWidth: 300,
                      height: 55,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        onPressed: () async {
                          final _uid = await authController.getCurrentUID();
                          Future<DocumentSnapshot> docSnapshot =
                              firebaseFirestore
                                  .collection('challenges')
                                  .doc(widget.challenge!.id)
                                  .get();
                          DocumentSnapshot doc = await docSnapshot;
                          if (doc["completedBy"].contains(_uid)) {
                            await firebaseFirestore
                                .collection('challenges')
                                .doc(widget.challenge!.id)
                                .update({
                              "completedBy": FieldValue.arrayRemove([_uid])
                            });
                          } else {
                            await firebaseFirestore
                                .collection('challenges')
                                .doc(widget.challenge!.id)
                                .update({
                              "completedBy": FieldValue.arrayUnion([_uid])
                            });
                          }
                        },
                        color: Colors.grey[200],
                        textColor: Colors.blue[800],
                        child: const Text("Let's do it!",
                            style: TextStyle(fontSize: 20)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
