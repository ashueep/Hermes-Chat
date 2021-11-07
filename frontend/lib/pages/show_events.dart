import 'package:chat_app_project/pages/add_new_event.dart';
import 'package:chat_app_project/pages/group_channels.dart';
import 'package:chat_app_project/widgets/list_of_events.dart';
import 'package:chat_app_project/widgets/new_list_of_roles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class show_events extends StatefulWidget {
  int g_index;
  show_events({required this.g_index});

  @override
  _show_eventsState createState() => _show_eventsState(g_index: g_index);
}

class _show_eventsState extends State<show_events> {
  int g_index;
  _show_eventsState({required this.g_index});
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
      floatingActionButton: FloatingActionButton(
       onPressed: () {
        Navigator.push(context,
             MaterialPageRoute(builder: (context) => add_new_event_page(g_index: g_index)));
       },
       child: const Icon(Icons.add_circle_outline_sharp),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.orange,
      //   items: [BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined), label: "ADD NEW ROLE"),
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
          "HERMES Events",
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

                  list_pf_events(g_index: g_index,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
