import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:social_media/constants/controllers.dart';
import 'package:social_media/constants/firebase.dart';
import 'package:social_media/models/post.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  File? image;
  String? imageUrl;
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      var imageu = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        image = File(imageu!.path);
      });
    }

    Future uploadPic(BuildContext context) async {
      String fileName = basename(image!.path);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = firebaseStorageRef.putFile(image!);
      var _downurl = (await uploadTask
          .whenComplete(() => firebaseStorageRef.getDownloadURL()));
      var _url = _downurl.toString();
      setState(() {
        imageUrl = _url;
      });
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Create a new post",
          style: TextStyle(color: Colors.blue[800]),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          padding: const EdgeInsets.all(10.0),
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.blue[800],
        ),
      ),
      body: ListView(children: <Widget>[
        Builder(
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.40,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: (image != null)
                            ? FileImage(
                                image!,
                              )
                            : const AssetImage(
                                "assets/images/empty_image.png",
                              ) as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      size: 30.0,
                    ),
                    onPressed: () {
                      getImage();
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: TextField(
                  controller: _descriptionController,
                  maxLines: 8,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(color: Colors.blue)),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    labelStyle: TextStyle(color: Colors.blue[800]),
                    labelText: 'Description',
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ButtonTheme(
                minWidth: 120,
                height: 50,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.white,
                  onPressed: () async {
                    if (image != null) {
                      await uploadPic(context);
                      final uid = await authController.getCurrentUID();
                      Post post = Post(
                          uid: uid.toString(),
                          postText: _descriptionController.text,
                          postImage: imageUrl,
                          numberLikes: 0,
                          numberComments: 0,
                          timeCreated: Timestamp.now());
                      await firebaseFirestore
                          .collection("posts")
                          .add(post.toJson());
                      Navigator.pop(context);
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Please, upload the picture!"),
                      ));
                    }
                  },
                  elevation: 4.0,
                  splashColor: Colors.blue[800],
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              )
            ],
          ),
        ),
      ]),
    );
  }
}
