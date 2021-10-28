import 'package:chat_app_project/models/Groups.dart';
import 'package:chat_app_project/pages/Groups_Page.dart';
import 'package:chat_app_project/pages/change_event_details.dart';
import 'package:chat_app_project/pages/change_role_name_page.dart';
import 'package:chat_app_project/pages/edit_event_members.dart';
import 'package:chat_app_project/pages/edit_roles_and_permissions.dart';
import 'package:chat_app_project/pages/event_members_display.dart';
import 'package:chat_app_project/pages/show_roles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class list_pf_events extends StatefulWidget {
  const list_pf_events({Key? key}) : super(key: key);

  @override
  _list_pf_eventsState createState() => _list_pf_eventsState();
}

class _list_pf_eventsState extends State<list_pf_events> {
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
          content: new Text("Are you sure you want to delete the event $event?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("CANCEL"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
                onPressed: () {Navigator.push(context,
                    MaterialPageRoute(builder: (context) => show_roles()));},
                child: new Text("YES"))
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
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
            itemCount: events.length,
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
                  EdgeInsets.symmetric(horizontal: 7.5, vertical: 10.0),
                  decoration: BoxDecoration(
                      color: colors[k],
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
                                  events[k] ,
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
                                  "Event Description: " + events[k],
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
                            onSelected: (String value){
                              if(value=='edit event members'){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => event_members_page_edit_event_members()));
                              }

                              else if(value=='edit event name')
                              {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => change_event_details()));
                              }

                              else if(value=='delete event')
                              {
                                _showDialog_for_confirm_delete_event(context, groups[k].Group_name);
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
