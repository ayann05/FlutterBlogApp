import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blogapp/pages/home_content.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_database/firebase_database.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class addBlog extends StatefulWidget {
  const addBlog({super.key});

  @override
  State<addBlog> createState() => _addBlogState();
}

class _addBlogState extends State<addBlog> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  //firebase database aur firebase storage k references
  final postDatabaseRef = FirebaseDatabase.instance.reference().child('Posts');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  //image variable
  File? _image;

  //will pick up the image
  final picker = ImagePicker();

  TextEditingController blogTitle = TextEditingController();
  TextEditingController blogBody = TextEditingController();

  //gallery se image uthane k liye function
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected');
        showToast('No image Selected');
      }
    });
  }

  //camera se image khichne k liye function
  Future getImageFromCamera() async {
    final pickedImageFromCamera =
        await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedImageFromCamera != null) {
        _image = File(pickedImageFromCamera.path);
      } else {
        print('No Image Captured');
        showToast('No Image Capture');
      }
    });
  }

  void dialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            content: Container(
              height: 120,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      getImageFromCamera();
                      Navigator.pop(context);
                    },
                    child: const ListTile(
                      leading: Icon(CupertinoIcons.camera),
                      title: Text(
                        "Camera",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      getImageFromGallery();
                      Navigator.pop(context);
                    },
                    child: const ListTile(
                      leading: Icon(CupertinoIcons.photo),
                      title: Text(
                        "Gallery",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            "Unleash Your Stories",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 6,
                ),

                //camera button
                InkWell(
                  onTap: () {
                    dialog(context);
                  },
                  child: Center(
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      child: _image != null
                          ? Image.file(
                              _image!.absolute,
                              height: 150,
                              width: 150,
                              fit: BoxFit.fitHeight,
                            )
                          : Container(
                              alignment: Alignment.bottomRight,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              width: 80,
                              height: 80,
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  CupertinoIcons.camera,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                    ),
                  ),
                ),

                //Blog Title and Blog Description
                Form(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: blogTitle,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            labelText: 'Title',
                            hintText: 'Enter Blog Title',
                            hintStyle: TextStyle(color: Colors.grey),
                            labelStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          cursorColor: Colors.black,
                          controller: blogBody,
                          keyboardType: TextInputType.multiline,
                          maxLines: 100, // Adjust based on your needs
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                            labelText: 'Description',
                            hintText: 'Blog Description',
                            hintStyle: TextStyle(color: Colors.grey),
                            labelStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none,
                            alignLabelWithHint: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),

                //Blog Submission Button
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      int date = DateTime.now().millisecondsSinceEpoch;

                      firebase_storage.Reference ref = firebase_storage
                          .FirebaseStorage.instance
                          .ref('/Blog Harbor $date');

                      //image upload krne k tarika
                      UploadTask uploadTask = ref.putFile(_image!.absolute);
                      await Future.value(uploadTask);

                      //upload image k url
                      var newUrl = await ref.getDownloadURL();
                      final User? user = _auth.currentUser;
                      postDatabaseRef
                          .child('Post List')
                          .child(date.toString())
                          .set({
                        'postId': date.toString(),
                        'postImage': newUrl.toString(),
                        'postTime': date.toString(),
                        'postTitle': blogTitle.text.toString(),
                        'postDescription': blogBody.text.toString(),
                        'postEmail': user!.email.toString(),
                        'postUID': user!.uid.toString(),
                      }).then((value) {
                        print('Post Published');
                        showToast('Post Published');
                        setState(() {
                          showSpinner = false;
                        });
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeContent()));
                      }).onError((error, stackTrace) {
                        print(error);
                        showToast(error.toString());
                        setState(() {
                          showSpinner = false;
                        });
                      });
                    } catch (e) {
                      setState(() {
                        showSpinner = false;
                      });
                      print(e);
                      showToast(e.toString());
                    }
                  },
                  child: const Icon(CupertinoIcons.checkmark_alt_circle),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
