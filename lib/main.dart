import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blogapp/intro/splash.dart';
import 'package:flutter_blogapp/themes/customTheme.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const flutterBlog());
}

class flutterBlog extends StatefulWidget {
  const flutterBlog({super.key});

  @override
  State<flutterBlog> createState() => _flutterBlogState();
}

class _flutterBlogState extends State<flutterBlog> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Meme APP",
      theme: ThemeData(
        backgroundColor: Colors.white,
        fontFamily: GoogleFonts.dmSans().fontFamily,
        useMaterial3: true,
        colorScheme: myCustomTheme.darkColorScheme,
      ),
      routes: {
        '/': (context) => splashScreen(),
      },
    );
  }
}
