import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final databaseRef = FirebaseDatabase.instance.reference().child('Posts');
  List<String> likedPostIds = []; // Add a list to store liked post IDs

  TextEditingController searchController = TextEditingController();
  String search = "";

  bool searchClicked = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            "Your Blog Content",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          actions: [
            InkWell(
              onTap: () {
                setState(() {
                  searchClicked = !searchClicked;
                });
              },
              child: Icon(
                CupertinoIcons.search,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Visibility(
                  visible: searchClicked,
                  child: TextFormField(
                    cursorColor: Colors.black,
                    controller: searchController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Search with Blog Title',
                      labelText: 'Blog Title',
                      labelStyle: TextStyle(color: Colors.black),
                      prefixIcon: const Icon(CupertinoIcons.paragraph),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (String value) {
                      search = value;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: FirebaseAnimatedList(
                  query: databaseRef.child('Post List'),
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    final data = snapshot.value as Map<dynamic, dynamic>;
                    final postId = snapshot.key;
                    String temporaryBlogTitle = data['postTitle'];
                    //searching
                    if (searchController.text.isEmpty) {
                      if (snapshot.value == null) {
                        return const CircularProgressIndicator();
                      } else {
                        return Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FadeInImage.assetNetwork(
                                placeholder: 'assets/errorImage.png',
                                image: data['postImage'],
                                height: 120,
                                width: 120,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  data['postTitle'],
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  data['postDescription'],
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Divider(
                                  height: 0.1,
                                  thickness: 2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.favorite,
                                        color: likedPostIds.contains(postId)
                                            ? Colors.red
                                            : Colors.black,
                                      ),
                                      onPressed: () {
                                        // Handle favorite button press
                                        setState(() {
                                          if (likedPostIds.contains(postId)) {
                                            likedPostIds.remove(postId);
                                          } else {
                                            likedPostIds.add(postId!);
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    } else if (temporaryBlogTitle
                        .toLowerCase()
                        .contains(searchController.text.toString())) {
                      if (snapshot.value == null) {
                        return const CircularProgressIndicator();
                      } else {
                        final data = snapshot.value as Map<dynamic, dynamic>;
                        final postId = snapshot.key;

                        return Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FadeInImage.assetNetwork(
                                placeholder: 'assets/errorImage.png',
                                image: data['postImage'],
                                height: 120,
                                width: 120,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  data['postTitle'],
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  data['postDescription'],
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Divider(
                                  height: 0.1,
                                  thickness: 2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.favorite,
                                        color: likedPostIds.contains(postId)
                                            ? Colors.red
                                            : Colors.black,
                                      ),
                                      onPressed: () {
                                        // Handle favorite button press
                                        setState(() {
                                          if (likedPostIds.contains(postId)) {
                                            likedPostIds.remove(postId);
                                          } else {
                                            likedPostIds.add(postId!);
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
