import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blogapp/pages/add.dart';
import 'package:flutter_blogapp/pages/home_content.dart';
import 'package:flutter_blogapp/pages/like.dart';
import 'package:flutter_blogapp/views/profile.dart';
import 'package:flutter_blogapp/views/register.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? _currentUser = FirebaseAuth.instance.currentUser;

  void _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            signUpScreen(), // Use SignUpScreen instead of signUpScreen
      ),
    );
  }

  String _getUserName(String email) {
    return email.split('@').first;
  }

  // Bottom nav bar
  int _selectedIndex = 1;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    likeBlogs(),
    HomeContent(),
    addBlog(),
  ];
  @override
  Widget build(BuildContext context) {
    String userName = _getUserName(_currentUser?.email ?? "");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Blog Harbor",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            SizedBox(
              height: 200,
              child: UserAccountsDrawerHeader(
                accountName: Text(
                  userName,
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                accountEmail: Text(
                  _currentUser?.email ?? "",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(_currentUser?.photoURL ?? ""),
                ),
              ),
            ),
            ListTile(
              title: const Text("Profile"),
              leading: const Icon(Icons.person),
              onTap: () {
                // Add your profile action here
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
            ),
            Divider(),
            ListTile(
              title: const Text("Sign Out"),
              leading: const Icon(Icons.exit_to_app),
              onTap: _signOut,
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 5),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  '"Unleash Your Thoughts, Share Your Stories"',
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  speed: Duration(milliseconds: 100),
                ),
              ],
              totalRepeatCount: 360,
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _pages[_selectedIndex], // Use the selected page
            ),
          ],
        ),
      ),
      bottomNavigationBar: GNav(
        selectedIndex: _selectedIndex,
        onTabChange: _navigateBottomBar,
        tabs: [
          GButton(
            icon: CupertinoIcons.heart,
            iconColor: Colors.red,
          ),
          GButton(
            icon: CupertinoIcons.home,
            iconColor: Colors.green,
          ),
          GButton(
            icon: CupertinoIcons.add,
            iconColor: Colors.amber,
          ),
        ],
      ),
    );
  }
}
