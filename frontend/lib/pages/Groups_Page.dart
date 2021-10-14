import 'dart:ui';

import 'package:chat_app_project/widgets/Category_selector.dart';
import 'package:chat_app_project/widgets/Category_selector_for_groups.dart';
import 'package:chat_app_project/widgets/Groups_chats.dart';
import 'package:chat_app_project/widgets/messages_sent_recieved.dart';
import 'package:flutter/material.dart';

class Group_Page extends StatefulWidget {
  Group_Page({Key? key}) : super(key: key);

  @override
  _Group_PageState createState() => _Group_PageState();
}

class _Group_PageState extends State<Group_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: Icon(Icons.more_horiz),
          iconSize: 40.0,
          color: Colors.white,
          onPressed: () {},
        ),
        title: Text(
          "Groups",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
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
          CategorySelector_for_group(),
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
                  Groups_chats(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
