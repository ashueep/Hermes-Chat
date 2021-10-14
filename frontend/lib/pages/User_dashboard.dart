// ignore_for_file: file_names

import 'package:chat_app_project/models/message_model.dart';
import 'package:chat_app_project/widgets/Category_selector.dart';
import 'package:chat_app_project/widgets/messages_sent_recieved.dart';
import 'package:chat_app_project/widgets/recent_chats_widget.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class User_dashboard extends StatefulWidget {
  @override
  _User_dashboard_state createState() => _User_dashboard_state();
}

class _User_dashboard_state extends State<User_dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          iconSize: 40.0,
          color: Colors.white,
          onPressed: () {},
        ),
        title: Text('Dashboard',
            style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold)),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 40.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          CategorySelector(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28.0),
                    topRight: Radius.circular(28.0),
                  )),
              child: Column(
                children: <Widget>[
                  recent_chats(),
                  chats_received_sent(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
