import 'package:chat_app_project/pages/edit_event_members.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class event_members_page_edit_event_members extends StatefulWidget {
  const event_members_page_edit_event_members({Key? key}) : super(key: key);

  @override
  _event_members_page_edit_event_membersState createState() => _event_members_page_edit_event_membersState();
}

class _event_members_page_edit_event_membersState extends State<event_members_page_edit_event_members> {
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
      //floatingActionButton: FloatingActionButton(
      //  onPressed: () {
      //   Navigator.push(context,
      //        MaterialPageRoute(builder: (context) => create_new_account()));
      //  },
      //  child: const Icon(Icons.add_circle_outline_sharp),
      //),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.orange,
        onTap: onTabTapped,
        currentIndex: curr_index,
        items: [BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined), label: "CONFIRM CHANGES"),
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
          "Event Members",
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

                  edit_event_members(),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
