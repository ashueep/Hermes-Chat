import 'dart:ui';
import 'package:chat_app_project/pages/create_new_group.dart';
import 'package:chat_app_project/widgets/Category_selector.dart';
import 'package:chat_app_project/widgets/Category_selector_for_groups.dart';
import 'package:chat_app_project/widgets/Groups_chats.dart';
import 'package:chat_app_project/widgets/messages_sent_recieved.dart';
import 'package:chat_app_project/widgets/recent_chats_widget.dart';
import 'package:flutter/material.dart';


class Group_Page extends StatefulWidget {


  @override
  _Group_PageState createState() => _Group_PageState();
}

class _Group_PageState extends State<Group_Page> {

  void _showDialog_for_login_failure(BuildContext context,String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Alert!"),
          content: new Text(message),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: true ? FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => create_new_group_hermes()));
        },
        child: const Icon(Icons.add_circle_outline_sharp),
      ): SizedBox.shrink(),
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
