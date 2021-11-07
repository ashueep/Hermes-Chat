import 'package:chat_app_project/group_requests/edit_event_members_request_to_API.dart';
import 'package:chat_app_project/models/Groups_class_final.dart';
import 'package:chat_app_project/pages/edit_event_members.dart';
import 'package:chat_app_project/pages/group_channels.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class event_members_page_edit_event_members extends StatefulWidget {
  int g_index;
  int event_index;
  event_members_page_edit_event_members({required this.g_index,required this.event_index});

  @override
  _event_members_page_edit_event_membersState createState() => _event_members_page_edit_event_membersState(g_index: g_index,event_index: event_index);
}

class _event_members_page_edit_event_membersState extends State<event_members_page_edit_event_members> {
  int curr_index=0;
  int g_index;
  int event_index;
  _event_members_page_edit_event_membersState({required this.g_index,required this.event_index});
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
         List<String> attendees_to_be_sent = [];
         for(int i=0;i<bool_for_roles_part_of_event.length;i++)
           {
             if(bool_for_roles_part_of_event[i]==true)
               {
                 attendees_to_be_sent.add(list_of_groups[g_index].all_roles[i].role_name.toString());
               }
           }
         List<String> response_from_API = await edit_event_members_request(list_of_groups[g_index].events_that_group_member_is_part_of[event_index].event_id, list_of_groups[g_index].group_id, attendees_to_be_sent);
        Navigator.push(context,
             MaterialPageRoute(builder: (context) => group_channels(index: g_index,)));
       },
       child: const Icon(Icons.add_circle_outline_sharp),
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

                  edit_event_members(g_index: g_index,event_index: event_index,),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
