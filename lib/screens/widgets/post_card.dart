import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:social_media/constants/controllers.dart';
import 'package:social_media/models/post.dart';
import 'package:social_media/models/user_info.dart';
import 'package:social_media/screens/main/user_profile.dart';

class PostCard extends StatelessWidget {
  final Post? post;
  const PostCard({Key? key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: userController.getProfileData(post!.uid!),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            UserInfo userInfo = UserInfo.fromDocSnapshot(snapshot.data!);
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 270,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(post!.postImage!),
                          fit: BoxFit.cover)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Challenge",
                      style: TextStyle(
                          color: Colors.blue[800],
                          fontSize: 16,
                          fontWeight: FontWeight.w800),
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
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    UserProfile(profileId: post!.uid!)));
                          },
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
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        userInfo.userName!,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
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
                          post!.postText!,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    rowItem(Icons.arrow_upward, post!.numberLikes.toString()),
                    rowItem(Icons.comment, post!.numberComments!.toString()),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            );
          } else {
            return Container();
          }
        });
  }

  Widget rowItem(IconData dataIcon, String data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(
            dataIcon,
            color: Colors.blue[800],
          ),
          const SizedBox(width: 5),
          Text(data),
        ],
      ),
    );
  }
}
