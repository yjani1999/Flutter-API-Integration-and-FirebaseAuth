// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

String stringResponse = '';
Map mapResponse = {};
Map dataResponse = {};

class Profile extends StatefulWidget {
  static String route = 'profile';
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    apiCall();
    super.initState();
  }

  apiCall() async {
    http.Response response;
    response = await http.get(Uri.parse('https://reqres.in/api/users/2'),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      setState(() {
        // stringResponse = response.body;
        mapResponse = jsonDecode(response.body);
        dataResponse = mapResponse['data'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text(
          'User Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //show user Image
                CircleAvatar(
                  radius: 80,
                  backgroundImage:
                      NetworkImage(dataResponse['avatar'].toString()),
                ),
                SizedBox(
                  height: 24,
                ),

                //show user's First Name
                Container(
                  child: Text(
                      'Name: ${dataResponse['first_name'].toString()}  ${dataResponse['last_name'].toString()}'),
                ),
                SizedBox(
                  height: 24,
                ),
                //show user emailaddress
                Container(
                  child: Text('Email: ${dataResponse['email'].toString()}'),
                ),
              ]),
        ),
      ),
    );
  }
}
