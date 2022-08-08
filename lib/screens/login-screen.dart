// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_typing_uninitialized_variables, file_names, avoid_print

import 'package:firstapp/resources/auth_methods.dart';
import 'package:firstapp/screens/dashboard.dart';
import 'package:firstapp/screens/signup-screen.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/widgets/text_field_widget.dart';

var loginContext;

class LoginScreen extends StatefulWidget {
  static String route = 'login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool userSignedIn = false;
  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),

              const SizedBox(
                height: 64,
              ),

              //field for email
              TextFieldInput(
                  textEditingController: _emailController,
                  hintText: 'Enter your email',
                  textInputType: TextInputType.emailAddress),

              const SizedBox(
                height: 24,
              ),
              //text field for password

              TextFieldInput(
                textEditingController: _passwordController,
                hintText: 'Enter your Password',
                textInputType: TextInputType.visiblePassword,
                isPass: true,
              ),

              const SizedBox(
                height: 24,
              ),
              //button for submit
              GestureDetector(
                onTap: () async {
                  String res = await AuthMehods().signInUser(
                      email: _emailController.text,
                      password: _passwordController.text);
                  print(res);
                  if (res == 'Signing in Successful') {
                    userSignedIn = true;
                    // ignore: use_build_context_synchronously
                    Navigator.pushNamed(context, Dashboard.route);
                  }
                  print(userSignedIn);
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: Colors.blue,
                  ),
                  child: const Text('Log in'),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),

              //transition to sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text("Don't have an account? "),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignupScreen.route);
                    },
                    child: Container(
                      child: Text(
                        'Sign up',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
