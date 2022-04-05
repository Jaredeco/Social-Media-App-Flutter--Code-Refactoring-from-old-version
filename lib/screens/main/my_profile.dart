import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/constants/controllers.dart';
import 'package:social_media/models/user_info.dart';

class MyProfile extends StatefulWidget {
  final String? pushedUrl;
  const MyProfile({Key? key, this.pushedUrl}) : super(key: key);
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final TextEditingController _userBioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String uid = authController.getCurrentUID();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.blue[800]),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue[800],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            padding: const EdgeInsets.all(10.0),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              authController.signOut();
            },
            color: Colors.red,
          ),
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
          future: userController.getProfileData(uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              UserInfo userInfo = UserInfo.fromDocSnapshot(snapshot.data!);
              return SingleChildScrollView(
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Stack(
                      fit: StackFit.loose,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 140.0,
                              height: 140.0,
                              child: CachedNetworkImage(
                                imageUrl: widget.pushedUrl == null
                                    ? userInfo.userImage!
                                    : widget.pushedUrl!,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  width: 80.0,
                                  height: 80.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ],
                        ),
                      ],
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
                  Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
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
                          horizontal: 8.0, vertical: 19.0),
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
                  Divider(
                    color: Colors.blue[800],
                    height: 0,
                  ),
                ]),
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
