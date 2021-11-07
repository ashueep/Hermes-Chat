import 'package:chat_app_project/group_requests/create_a_new_role.dart';
import 'package:chat_app_project/models/Groups_class_final.dart';
import 'package:chat_app_project/pages/add_channel_permissions_for_new_role_page.dart';
import 'package:chat_app_project/pages/add_permissions_for_new_role.dart';
import 'package:chat_app_project/pages/group_channels.dart';
import 'package:chat_app_project/pages/show_roles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'create_new_group.dart';

class add_group_permissions_page extends StatefulWidget {
  int g_index;
  String role_name_new;
  add_group_permissions_page({required this.g_index,required this.role_name_new});

  @override
  _add_group_permissions_pageState createState() => _add_group_permissions_pageState(g_index: g_index,role_name_new: role_name_new);
}

class _add_group_permissions_pageState extends State<add_group_permissions_page> {
  int g_index;
  String role_name_new;
  _add_group_permissions_pageState({required this.g_index,required this.role_name_new});
  int curr_index=0;
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

    void onTabTapped(int index) {
      if(index==0)
      {

      }
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
       onPressed: () async {
         List<String> response_from_API = await create_new_role(role_name_new, value2, list_of_groups[g_index].group_id);
        Navigator.push(context,
             MaterialPageRoute(builder: (context) => group_channels(index: g_index,)));
       },
       child: const Icon(Icons.arrow_forward_ios_outlined),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.orange,
      //   onTap: onTabTapped,
      //   currentIndex: curr_index,
      //   items: [BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined), label: "CONFIRM CHANGES"),
      //     BottomNavigationBarItem(icon: Icon(Icons.arrow_back_ios_new_outlined), label: "RETURN"),
      //   ],
      //
      // ),
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
          "Group Permissions",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28.0,
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

                  add_permissions_for_new_role(g_index: g_index,),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
