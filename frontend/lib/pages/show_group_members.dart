import 'package:chat_app_project/pages/create_new_member_page.dart';
import 'package:chat_app_project/widgets/list_of_group_members.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'create_new_role.dart';

class show_group_members extends StatefulWidget {
  int g_index;
  show_group_members({required this.g_index});

  @override
  _show_group_membersState createState() => _show_group_membersState(g_index: g_index);
}

class _show_group_membersState extends State<show_group_members> {
  @override
  int g_index;
  _show_group_membersState({required this.g_index});
  int selected_index=0;
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

    // void onItemTapped(int index) async
    // {
    //   if(index==0)
    //     {
    //       print("hello this is add new role!");
    //     }
    // }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => create_new_group_member(g_index: g_index,)));
        },
        child: const Icon(Icons.add_circle_outline_sharp),
      ),

      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.orange,
      //   items: [BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined), label: "ADD NEW ROLE"),
      //     BottomNavigationBarItem(icon: Icon(Icons.arrow_back_ios_new_outlined), label: "RETURN"),
      //   ],
      //   currentIndex: selected_index,
      //   onTap: onItemTapped(),

      //),
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
          "Group Members",
          style: TextStyle(
            color: Colors.white,
            fontSize: 27.0,
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

                  list_of_group_members(g_index: g_index,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
