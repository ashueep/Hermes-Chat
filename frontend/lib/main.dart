import 'package:chat_app_project/pages/User_dashboard.dart';
import 'package:chat_app_project/pages/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(Chat_app());

class Chat_app extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "chatapp UI",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
      //home: User_dashboard(),
      home: LoginScreen(),
    );
  }
}
