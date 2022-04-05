import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/constants/controllers.dart';
import 'package:social_media/controllers/post_controller.dart';
import 'package:social_media/screens/main/create_screens/create_post.dart';
import 'package:social_media/screens/widgets/app_bar.dart';
import 'package:social_media/screens/widgets/post_card.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: topAppBar(),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.add,
              color: Colors.blue[800],
            ),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CreatePost()));
            }),
        body: GetX<PostController>(builder: (PostController pc) {
          if (pc != null && pc.posts != null) {
            return ListView(
                children: pc.posts
                    .map((item) => PostCard(post: item))
                    .toList()
                    .cast<Widget>());
          } else {
            return Container();
          }
        }));
  }
}
