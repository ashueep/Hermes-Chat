// ignore_for_file: file_names

import 'package:chat_app_project/models/logout_request.dart';
import 'package:chat_app_project/models/message_model.dart';
import 'package:chat_app_project/pages/login_page.dart';
import 'package:chat_app_project/widgets/Category_selector.dart';
import 'package:chat_app_project/widgets/messages_sent_recieved.dart';
import 'package:chat_app_project/widgets/recent_chats_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'create_new_DM.dart';
import 'create_new_group.dart';

// ignore: camel_case_types
class User_dashboard extends StatefulWidget {
  @override
  _User_dashboard_state createState() => _User_dashboard_state();
}

class _User_dashboard_state extends State<User_dashboard> {
  @override

  menu_handler(context,item)async
  {
    switch(item){
      case 0: List<String> received_logout_response= await logout_request();
      print(received_logout_response[0]);
      print(received_logout_response[1]);
      if(received_logout_response[1]=="true")
      {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => LoginScreen()));
      }
      else
      {
        _showDialog_for_logout_failure(context,received_logout_response[0]);
      }
    }
  }

  void _showDialog_for_logout_failure(BuildContext context,String message) {
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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => create_new_account_DM()));
        },
        child: const Icon(Icons.add_circle_outline_sharp),
      ),
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,

            actions: [
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text("LOGOUT",style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ],onSelected: (item) => menu_handler(context, item,),
            ),
    ],




        title: Text('Dashboard',
            style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold)),
        elevation: 0.0,
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


