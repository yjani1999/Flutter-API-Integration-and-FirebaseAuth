// ignore_for_file: unused_import, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/resources/storage_methods.dart';
import 'package:firstapp/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMehods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //signUp User
  Future<String> signUpUser({
    required BuildContext cusContext,
    required String email,
    required String password,
    required String username,
    required Uint8List file,
    // required Uint8List file,
  }) async {
    String res = "Error Occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty) {
        //register the user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        var user = cred.user;
        var userData = {
          "uid": user?.uid,
          "email": user?.email,
        };
        String photoUrl =
            await StorageMethods().uploadImageToStorage('profilePics', file);

        //add user to our databasse
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'photoUrl': photoUrl,
        });
        res = 'Success';
        if (res == 'Success') {
          Navigator.pushNamed(cusContext, Dashboard.route);
          var any = await SharedPreferences.getInstance();
          any.clear();
          any.setString('userData', jsonEncode(userData));
        }
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //signin user
  Future<String> signInUser(
      {required String email, required String password}) async {
    String res = "Error Occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        //register the user
        UserCredential cred = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        var user = cred.user;
        var userData = {
          "uid": user?.uid,
          "email": user?.email,
        };

        var any = await SharedPreferences.getInstance();
        any.setString('userData', jsonEncode(userData));
        any.setString('uid', userData['uid'].toString());

        res = 'Signing in Successful';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //try auto login
  Future tryAutologin() async {
    var any = await SharedPreferences.getInstance();
    if (!any.containsKey('userData')) {
      return false;
    } else {
      return true;
    }
  }

  //signout user
  Future<String> signOutUser() async {
    String res = "Error Occured";
    try {
      {
        await _auth.signOut();

        res = 'Signout Successful';
        var any = await SharedPreferences.getInstance();
        any.remove('userData');
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
