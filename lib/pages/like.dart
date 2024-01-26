import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class likeBlogs extends StatefulWidget {
  const likeBlogs({super.key});

  @override
  State<likeBlogs> createState() => _likeBlogsState();
}

class _likeBlogsState extends State<likeBlogs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Liked Blogs",
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        actions: [
          InkWell(
            onTap: () {},
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
      body: Container(color: Colors.white),
    );
  }
}
