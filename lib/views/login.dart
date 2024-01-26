import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blogapp/components/round_button.dart';
import 'package:flutter_blogapp/google_login_service/gAuth_service.dart';
import 'package:flutter_blogapp/views/forgetPassword.dart';
import 'package:flutter_blogapp/views/home_screen.dart';
import 'package:flutter_blogapp/views/register.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class logInScreen extends StatefulWidget {
  const logInScreen({super.key});

  @override
  State<logInScreen> createState() => _logInScreenState();
}

class _logInScreenState extends State<logInScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String email = "";
  String password = "";

  bool _secureText = true;

  bool showSpinner = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => signUpScreen())),
            ),
            title: const Text(
              "Enter your credentials",
              style: TextStyle(fontSize: 18),
            ),
          ),
          body: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Let's LogIn",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          cursorColor: Colors.black,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Email',
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.black),
                            prefixIcon: const Icon(CupertinoIcons.mail),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onChanged: (String value) {
                            email = value;
                          },
                          validator: (value) {
                            return value!.isEmpty ? 'Enter your mail' : null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          cursorColor: Colors.black,
                          controller: passwordController,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Password',
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.black),
                            prefixIcon: const Icon(CupertinoIcons.padlock),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _secureText = !_secureText;
                                });
                              },
                              child: Icon(_secureText
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          obscureText: _secureText,
                          onChanged: (String value) {
                            password = value;
                          },
                          validator: (value) {
                            return value!.isEmpty
                                ? 'Enter your password'
                                : null;
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(250, 0, 0, 0),
                          child: InkWell(
                            child: Container(
                              child: const Text(
                                "Forget Password",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                            ),
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ForgetPassword()));
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: roundButton(
                            title: 'LogIn',
                            onPress: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  showSpinner = true;
                                });
                                try {
                                  final user = _auth.signInWithEmailAndPassword(
                                      email: email.toString().trim(),
                                      password: password.toString().trim());

                                  if (user != null) {
                                    print('Success');
                                    showToastMessage(
                                        'User LoggedIn successfully');
                                    setState(() {
                                      showSpinner = false;
                                    });
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeScreen()));
                                  }
                                } catch (e) {
                                  print(e);
                                  showToastMessage(e.toString());
                                  setState(() {
                                    showSpinner = false;
                                  });
                                }
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "OR",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        InkWell(
                          child: Container(
                            width: double.infinity,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/googlelogo.png',
                                  height: 50,
                                  width: 50,
                                ),
                              ],
                            ),
                          ),
                          onTap: () async {
                            UserCredential? userCredential =
                                await AuthService().signInWithGoogle();
                            if (userCredential != null) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
                            }
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  void showToastMessage(String message) {
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
