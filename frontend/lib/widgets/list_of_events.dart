import 'dart:math';

import 'package:chat_app_project/group_requests/delete_an_event.dart';
import 'package:chat_app_project/models/Groups.dart';
import 'package:chat_app_project/models/Groups_class_final.dart';
import 'package:chat_app_project/pages/Groups_Page.dart';
import 'package:chat_app_project/pages/change_event_details.dart';
import 'package:chat_app_project/pages/change_role_name_page.dart';
import 'package:chat_app_project/pages/edit_event_members.dart';
import 'package:chat_app_project/pages/edit_roles_and_permissions.dart';
import 'package:chat_app_project/pages/event_members_display.dart';
import 'package:chat_app_project/pages/group_channels.dart';
import 'package:chat_app_project/pages/show_roles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class list_pf_events extends StatefulWidget {
  int g_index;
  list_pf_events({required this.g_index});

  @override
  _list_pf_eventsState createState() => _list_pf_eventsState(g_index: g_index);
}

class _list_pf_eventsState extends State<list_pf_events> {
  int g_index;
  _list_pf_eventsState({required this.g_index});
  List<String> events=["Front end design progress week 3","College fest discussion","engineer tech fest"];
  List<Color> colors=[Colors.lightBlue,Colors.lightBlueAccent,Colors.lightGreen,Colors.lightGreenAccent,Colors.lime,Colors.limeAccent];
  @override

  Widget _buildNewRoleBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          print("add new role button pressed");
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'ADD NEW ROLE',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  void _showDialog_for_confirm_delete_event(BuildContext context,String event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Alert!"),
          content: new Text("$event"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("CANCEL"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
                onPressed: () {Navigator.push(context,
                    MaterialPageRoute(builder: (context) => show_roles(g_index: 0,)));},
                child: new Text("YES"))
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {

    Color _choose_random_color(){
      Random random = new Random();
      int randomNumber = random.nextInt(6) + 0;
      return colors[randomNumber];
    }

    return Expanded(
      child: Container(
        height: 278.0, //just used to test
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28.0),
            topRight: Radius.circular(28.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28.0),
            topRight: Radius.circular(28.0),
          ),
          child: ListView.builder(
            itemCount: list_of_groups[g_index].events_that_group_member_is_part_of.length,
            itemBuilder: (BuildContext context, int k) {
              return GestureDetector(
                onTap: () {print("role pressed");},
                child: Container(
                  margin: EdgeInsets.only(
                    top: 5.0,
                    bottom: 5.0,
                    right: 10.0,
                  ),
                  padding:
                  EdgeInsets.symmetric(horizontal: 7.5, vertical: 20.0),
                  decoration: BoxDecoration(
                      color: _choose_random_color(),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [
                          SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.50,
                                child: Text(
                                  list_of_groups[g_index].events_that_group_member_is_part_of[k].event_name,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              Container(
                                width: MediaQuery.of(context).size.width * 0.50,
                                child: Text(
                                  "Event Description: \n" + list_of_groups[g_index].events_that_group_member_is_part_of[k].event_description,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          PopupMenuButton(itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                value: 'edit event name',
                                child: Text('Edit Event Details',style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                              PopupMenuItem(
                                value: 'edit event members',
                                child: Text('Edit Event Members',style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                              PopupMenuItem(
                                value: 'delete event',
                                child: Text('Delete Event', style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                            ];
                          },
                            onSelected: (String value) async{
                              if(value=='edit event members'){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => event_members_page_edit_event_members(g_index: g_index,event_index: k,)));
                              }

                              else if(value=='edit event name')
                              {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => change_event_details(g_index: g_index,event_index: k,)));
                              }

                              else if(value=='delete event')
                              {
                                List<String> response_from_API = await delete_event_request(list_of_groups[g_index].events_that_group_member_is_part_of[k].event_id, list_of_groups[g_index].group_id);
                                // _showDialog_for_confirm_delete_event(context, groups[k].Group_name);
                                response_from_API[1] == "true" ?
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => group_channels(index: g_index,))) : _showDialog_for_confirm_delete_event(context, response_from_API[0]);
                              }
                            },
                          ),

                          SizedBox(height: 2.5),

                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
