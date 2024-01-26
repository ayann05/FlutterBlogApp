import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blogapp/views/home_screen.dart';
import 'package:flutter_blogapp/views/register.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen>
    with SingleTickerProviderStateMixin {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    final user = auth.currentUser;

    if (user != null) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const HomeScreen()));
      });
    } else {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const signUpScreen()));
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 200,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child: Image.asset(
                    "assets/blogImage.png",
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
