// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'package:firstapp/resources/auth_methods.dart';
import 'package:firstapp/screens/login-screen.dart';
import 'package:firstapp/screens/profile.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

String stringResponse = '';
Map mapResponse = {};
Map dataResponse = {};
List listResponse = [];

class Dashboard extends StatefulWidget {
  static String route = 'dashboard';
  const Dashboard({Key? key}) : super(key: key);
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    apiCall();
    super.initState();
  }

  apiCall() async {
    http.Response response;
    response = await http.get(Uri.parse('https://reqres.in/api/users?page=2'),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      setState(() {
        // stringResponse = response.body;
        mapResponse = jsonDecode(response.body);
        listResponse = mapResponse['data'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage:
                        NetworkImage(listResponse[index]['avatar'].toString()),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Text(
                        'Name: ${listResponse[index]['first_name'].toString()}  ${listResponse[index]['last_name'].toString()}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Email: ${listResponse[index]['email'].toString()}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
            ],
          );
        },
        itemCount: listResponse == null ? 0 : listResponse.length,
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Profile.route);
              },
              icon: Icon(FontAwesomeIcons.user)),
        ],
        leading: IconButton(
          onPressed: () async {
            String res = await AuthMehods().signOutUser();
            print(res);

            Navigator.popAndPushNamed(context, LoginScreen.route);
          },
          icon: Icon(FontAwesomeIcons.circleXmark),
        ),
        title: Center(
            child: const Text(
          'Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
    ));
  }
}
