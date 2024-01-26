import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blogapp/views/home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Auth to get the current user
  User? _currentUser = FirebaseAuth.instance.currentUser;

  // Function to get the username from the email
  String _getUserName(String email) {
    return email.split('@').first;
  }

  @override
  Widget build(BuildContext context) {
    String userName = _getUserName(_currentUser?.email ?? "");

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
        title: Text("Profile"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Container(
              height: 400,
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.brown,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      child: UserAccountsDrawerHeader(
                        decoration: BoxDecoration(color: Colors.brown),
                        currentAccountPicture: CircleAvatar(
                          backgroundImage:
                              NetworkImage(_currentUser?.photoURL ?? ""),
                        ),
                        accountName: Text(
                          userName,
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                        accountEmail: Text(
                          _currentUser?.email ?? "",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 40,
                    ),
                    Text(
                      "Made with Love by @ayann",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
