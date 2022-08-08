// ignore_for_file: prefer_const_constructors

import 'package:firstapp/screens/dashboard.dart';
import 'package:firstapp/screens/login-screen.dart';
import 'package:firstapp/screens/profile.dart';

import 'package:firstapp/screens/signup-screen.dart';

getRoutes() {
  return {
    LoginScreen.route: (context) => LoginScreen(),
    SignupScreen.route: (context) => SignupScreen(),
    Dashboard.route: (context) => Dashboard(),
    Profile.route: (context) => Profile(),
  };
}
