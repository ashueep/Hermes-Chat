import 'package:chat_app_project/widgets/Category_selector_for_groups.dart';
import 'package:chat_app_project/widgets/Groups_chats.dart';
import 'package:chat_app_project/widgets/List_of_roles.dart';
import 'package:chat_app_project/widgets/new_list_of_roles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'create_new_group.dart';

class show_roles extends StatefulWidget {
  const show_roles({Key? key}) : super(key: key);

  @override
  _show_rolesState createState() => _show_rolesState();
}

class _show_rolesState extends State<show_roles> {
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
      //floatingActionButton: FloatingActionButton(
      //  onPressed: () {
       //   Navigator.push(context,
      //        MaterialPageRoute(builder: (context) => create_new_account()));
      //  },
      //  child: const Icon(Icons.add_circle_outline_sharp),
      //),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.orange,
        items: [BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined), label: "ADD NEW ROLE"),
          BottomNavigationBarItem(icon: Icon(Icons.arrow_back_ios_new_outlined), label: "RETURN"),
        ],

      ),
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
          "HERMES Roles",
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

                  new_list_of_roles(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
