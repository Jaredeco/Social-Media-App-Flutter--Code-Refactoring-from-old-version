import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:like_button/like_button.dart';
import 'package:social_media/constants/controllers.dart';
import 'package:social_media/models/challenge.dart';
import 'package:social_media/models/user_info.dart';
import 'package:social_media/screens/main/challenge_screen.dart';
import 'package:social_media/screens/main/user_profile.dart';

class ChallengeCard extends StatelessWidget {
  final Challenge? challenge;
  const ChallengeCard({Key? key, required this.challenge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String uid = authController.getCurrentUID();
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChallengePage(challenge: challenge!)));
      },
      child: FutureBuilder<DocumentSnapshot>(
          future: userController.getProfileData(challenge!.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              UserInfo userInfo = UserInfo.fromDocSnapshot(snapshot.data!);
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 270,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(challenge!.imageVal!),
                            fit: BoxFit.cover)),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 20, right: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        challenge!.taskName!,
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
                              final _currUID = authController.getCurrentUID();
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
                            if (userInfo.uid != uid) {
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
                            challenge!.description!,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     LikeButton(
                  //       isLiked: snapshot.data![0],
                  //       likeCount: challenge!.numberLikes!,
                  //       likeBuilder: (bool isLiked) {
                  //         return Icon(
                  //           isLiked ? Icons.favorite : Icons.favorite_border,
                  //           color: isLiked ? Colors.blue[800] : Colors.grey,
                  //         );
                  //       },
                  //       onTap: challengeControler.onLikeButtonTapped,
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
