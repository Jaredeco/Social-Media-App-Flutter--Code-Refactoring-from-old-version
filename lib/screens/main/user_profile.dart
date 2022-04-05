import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/constants/controllers.dart';
import 'package:social_media/constants/firebase.dart';
import 'package:social_media/models/user_info.dart';
import 'package:social_media/screens/widgets/challengeCard.dart';
import 'package:social_media/screens/widgets/post_card.dart';

class UserProfile extends StatefulWidget {
  final String? profileId;
  const UserProfile({Key? key, @required this.profileId}) : super(key: key);
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _appbarController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.blue[800]),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          padding: const EdgeInsets.all(10.0),
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.blue[800],
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
          future: userController.getProfileData(widget.profileId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              UserInfo userInfo = UserInfo.fromDocSnapshot(snapshot.data!);
              return ListView(controller: _appbarController, children: <Widget>[
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: SizedBox(
                        width: 140.0,
                        height: 140.0,
                        child: CachedNetworkImage(
                          imageUrl: userInfo.userImage!,
                          imageBuilder: (context, imageProvider) => Container(
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
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        userInfo.userName!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: ButtonTheme(
                        minWidth: 150,
                        height: 40,
                        child: !userInfo.followers!.contains(snapshot.data)
                            ? RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: Colors.blue[800],
                                onPressed: () async {
                                  final _curUID =
                                      await authController.getCurrentUID();
                                  await firebaseFirestore
                                      .collection('userData')
                                      .doc(_curUID)
                                      .update({
                                    "following":
                                        FieldValue.arrayUnion([userInfo.uid])
                                  });
                                  await firebaseFirestore
                                      .collection('userData')
                                      .doc(userInfo.uid)
                                      .update({
                                    "followers":
                                        FieldValue.arrayUnion([_curUID])
                                  });
                                  setState(() {});
                                },
                                elevation: 4.0,
                                splashColor: Colors.blue[800],
                                child: const Text(
                                  'Follow',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                ),
                              )
                            : RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: Colors.blue[800],
                                onPressed: () async {
                                  final _curUID =
                                      authController.getCurrentUID();
                                  await firebaseFirestore
                                      .collection('userData')
                                      .doc(_curUID)
                                      .update({
                                    "following":
                                        FieldValue.arrayRemove([userInfo.uid])
                                  });
                                  await firebaseFirestore
                                      .collection('userData')
                                      .doc(userInfo.uid)
                                      .update({
                                    "followers":
                                        FieldValue.arrayRemove([_curUID])
                                  });
                                  setState(() {});
                                },
                                elevation: 4.0,
                                splashColor: Colors.blue[800],
                                child: const Text(
                                  'Unfollow',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, top: 10),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                userInfo.bio!,
                                style: const TextStyle(fontSize: 20),
                              )),
                        ),
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 22.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Completed",
                                    style: TextStyle(
                                      color: Colors.blue[800],
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "${userInfo.completed!.length}",
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Followers",
                                    style: TextStyle(
                                      color: Colors.blue[800],
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "${userInfo.followers!.length}",
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Following",
                                    style: TextStyle(
                                      color: Colors.blue[800],
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "${userInfo.following!.length}",
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
                Divider(
                  color: Colors.blue[800],
                  height: 0,
                ),
                BottomProfileFeed(
                  profileId: widget.profileId,
                ),
              ]);
            } else {
              return Container();
            }
          }),
    );
  }
}

class BottomProfileFeed extends StatefulWidget {
  final String? profileId;
  const BottomProfileFeed({Key? key, @required this.profileId})
      : super(key: key);

  @override
  _BottomProfileFeedState createState() => _BottomProfileFeedState();
}

class _BottomProfileFeedState extends State<BottomProfileFeed> {
  var tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FlatButton(
            splashColor: Colors.white,
            color: Colors.white,
            shape: tabIndex == 0
                ? RoundedRectangleBorder(
                    side: const BorderSide(
                        color: Colors.blue, width: 2, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(50))
                : RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
            onPressed: () {
              setState(
                () {
                  tabIndex = 0;
                },
              );
            },
            child:
                Text("Challenges", style: TextStyle(color: Colors.blue[800])),
          ),
          FlatButton(
            splashColor: Colors.white,
            color: Colors.white,
            shape: tabIndex == 1
                ? RoundedRectangleBorder(
                    side: const BorderSide(
                        color: Colors.blue, width: 2, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(50))
                : RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
            onPressed: () {
              setState(
                () {
                  tabIndex = 1;
                },
              );
            },
            child: Text(
              "Posts",
              style: TextStyle(color: Colors.blue[800]),
            ),
          ),
        ],
      ),
      tabIndex == 0
          ? ListView(
              children: challengeController.challenges
                  .map((item) => ChallengeCard(challenge: item))
                  .toList()
                  .cast<Widget>())
          : ListView(
              children: postController.posts
                  .map((item) => PostCard(post: item))
                  .toList()
                  .cast<Widget>())
    ]);
  }
}
