// ignore_for_file: prefer_const_constructors, avoid_print, use_build_context_synchronously, file_names
import 'dart:io';
import 'dart:typed_data';
import 'package:firstapp/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/widgets/text_field_widget.dart';
import 'package:firstapp/resources/auth_methods.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  static String route = 'signup';

  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  File file = File('');
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
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

              //circular widget to accept and show file
              Stack(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://images.unsplash.com/photo-1522252234503-e356532cafd5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=725&q=80'),
                        ),
                  Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: () async {
                          selectImage();
                        },
                        icon: Icon(Icons.add_a_photo_rounded),
                      )),
                ],
              ),
              SizedBox(height: 24),

              //Text field input for username
              TextFieldInput(
                  textEditingController: _usernameController,
                  hintText: 'Enter your username',
                  textInputType: TextInputType.text),
              const SizedBox(
                height: 24,
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

              // //Text field input for Bio
              // TextFieldInput(
              //     textEditingController: _bioController,
              //     hintText: 'Enter your bio',
              //     textInputType: TextInputType.text),
              // const SizedBox(
              //   height: 24,
              // ),
              //button for submit
              GestureDetector(
                onTap: () async {
                  String res = await AuthMehods().signUpUser(
                      cusContext: context,
                      file: _image!,
                      email: _emailController.text,
                      password: _passwordController.text,
                      username: _usernameController.text);

                  print(res);
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
                  child: const Text('Sign up'),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
