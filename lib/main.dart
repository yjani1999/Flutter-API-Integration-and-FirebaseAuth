// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/firebase_options.dart';
import 'package:firstapp/resources/routes.dart';
import 'package:firstapp/screens/dashboard.dart';
import 'package:firstapp/screens/login-screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/resources/auth_methods.dart';

bool autoLoginSuccessful = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBNIQtq_1GhstL5tqWfciSSS7VoVAT8xBg",
          appId: "1:1050766276758:web:9c3114ff00116c74136ab7",
          messagingSenderId: "1050766276758",
          projectId: "airsky-first-app",
          storageBucket: "airsky-first-app.appspot.com"),
    );
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  autoLoginSuccessful = await AuthMehods().tryAutologin();

  autoLoginSuccessful ? runApp(const MyApp1()) : runApp(const MyApp2());
}

class MyApp1 extends StatelessWidget {
  const MyApp1({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      initialRoute: Dashboard.route,
      routes: getRoutes(),
    );
  }
}

class MyApp2 extends StatelessWidget {
  const MyApp2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      initialRoute: LoginScreen.route,
      routes: getRoutes(),
    );
  }
}
