import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blogapp/components/round_button.dart';
import 'package:flutter_blogapp/google_login_service/gAuth_service.dart';
import 'package:flutter_blogapp/views/home_screen.dart';
import 'package:flutter_blogapp/views/login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class signUpScreen extends StatefulWidget {
  const signUpScreen({super.key});

  @override
  State<signUpScreen> createState() => _signUpScreenState();
}

class _signUpScreenState extends State<signUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String email = "";
  String password = "";

  bool _secureText = true;

  final _formKey = GlobalKey<FormState>();

  bool showSpinner = false;

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Create Your Account",
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
                  "Register",
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
                            labelStyle: const TextStyle(color: Colors.black),
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
                            labelStyle: const TextStyle(color: Colors.black),
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
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          obscureText: _secureText,
                          onChanged: (String value) {
                            password = value;
                          },
                          validator: (value) {
                            return value!.isEmpty ? "Enter Password" : null;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                            child: roundButton(
                          title: 'Register',
                          onPress: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                showSpinner = true;
                              });
                              try {
                                final user =
                                    await _auth.createUserWithEmailAndPassword(
                                        email: email.toString().trim(),
                                        password: password.toString().trim());

                                if (user != null) {
                                  print("Success");
                                  showToast(
                                      'User has been Successfully created');
                                  setState(() {
                                    showSpinner = false;
                                  });
                                }
                              } catch (e) {
                                print(e.toString());
                                showToast(e.toString());
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                            }
                          },
                        )),
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
                                const Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    "Register with Google",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account ",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                child: Container(
                                  child: Text(
                                    "LogIn",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => logInScreen()));
                                },
                              )
                            ],
                          ),
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
