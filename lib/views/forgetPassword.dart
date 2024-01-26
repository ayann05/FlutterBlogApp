import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blogapp/components/round_button.dart';
import 'package:flutter_blogapp/views/register.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();

  String email = "";
  // String password = "";

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
              "Forget Password",
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
                  "Enter mail to recover password",
                  style: TextStyle(
                    fontSize: 20,
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
                          height: 30,
                        ),
                        Container(
                          child: roundButton(
                            title: 'Recover Password',
                            onPress: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  showSpinner = true;
                                });
                                try {
                                  _auth
                                      .sendPasswordResetEmail(
                                          email:
                                              emailController.text.toString())
                                      .then((value) {
                                    setState(() {
                                      showSpinner = false;
                                    });
                                    showToastMessage(
                                        'Please check your mail, reset link has been sent to you via email');
                                  }).onError((error, stackTrace) {
                                    showToastMessage(error.toString());
                                    setState(() {
                                      showSpinner = false;
                                    });
                                  });
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
