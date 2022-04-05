import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/constants/controllers.dart';
import 'package:social_media/constants/firebase.dart';
import 'package:social_media/models/user_info.dart';
import 'package:social_media/screens/main/my_profile.dart';

PreferredSizeWidget topAppBar() {
  return AppBar(
    backgroundColor: Colors.white,
    leading: Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        customBorder: const CircleBorder(),
        splashColor: Colors.black,
        onTap: () {
          Get.to(MaterialPageRoute(builder: (context) => const MyProfile()));
        },
        child: FutureBuilder<DocumentSnapshot>(
            future:
                userController.getProfileData(authController.getCurrentUID()),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                return CachedNetworkImage(
                  imageUrl: UserInfo.fromDocSnapshot(snapshot.data!).userImage!,
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
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                );
              }
              return Container();
            }),
      ),
    ),
    title: Text(
      "Explore",
      style: TextStyle(color: Colors.blue[800]),
    ),
    actions: [
      IconButton(
          onPressed: () => authController.signOut(),
          icon: const Icon(Icons.exit_to_app, color: Colors.red))
    ],
  );
}
