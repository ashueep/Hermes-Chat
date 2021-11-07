import 'package:chat_app_project/pages/group_channels.dart';
import 'package:chat_app_project/pages/show_roles.dart';
import 'package:chat_app_project/widgets/list_of_channel_permissions_for_new_role.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class add_channel_perms_for_new_role extends StatefulWidget {
  int g_index;
  int chan_index;
  add_channel_perms_for_new_role({required this.g_index,required this.chan_index});

  @override
  _add_channel_perms_for_new_roleState createState() => _add_channel_perms_for_new_roleState(g_index: g_index,chan_index: chan_index);
}

class _add_channel_perms_for_new_roleState extends State<add_channel_perms_for_new_role> {
  int curr_index=0;
  int g_index;
  int chan_index;
  _add_channel_perms_for_new_roleState({required this.g_index,required this.chan_index});
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => group_channels(index: g_index,)));
      //   },
      //   child: const Icon(Icons.arrow_forward_ios_outlined),
      // ),
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
          "Channel Permissions",
          style: TextStyle(
            color: Colors.white,
            fontSize: 26.0,
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

                  list_of_channel_perms_for_new_role(g_index: g_index,chan_index: chan_index,),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
