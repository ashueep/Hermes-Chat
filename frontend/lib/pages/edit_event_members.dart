import 'dart:math';

import 'package:chat_app_project/models/Groups_class_final.dart';
import 'package:chat_app_project/pages/group_channels.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Groups_Page.dart';

List<bool> bool_for_roles_part_of_event=[];

class edit_event_members extends StatefulWidget {
  int g_index;
  int event_index;
  edit_event_members({required this.g_index,required this.event_index});

  @override
  _edit_event_membersState createState() => _edit_event_membersState(g_index: g_index,event_index: event_index);
}

class _edit_event_membersState extends State<edit_event_members> {
  @override
  int g_index;
  int event_index;
  _edit_event_membersState({required this.g_index,required this.event_index});
  //List<String> roles=["Teacher","Student","Principal","Administrator"];

  //List<String> permissions=["Edit Group Name","Delete Group","Add channels","add/modify/delete roles","add/remove members","Add/edit/delete events"];

  void initState(){
    bool_for_roles_part_of_event=[];
    for(int k=0;k<list_of_groups[g_index].all_roles.length;k++)
      {
        bool_for_roles_part_of_event.add(false);
      }

    for(int i=0;i<list_of_groups[g_index].all_roles.length;i++)
      {
        for(int j=0;j<list_of_groups[g_index].events_that_group_member_is_part_of[event_index].roles.length;j++)
          {
            if(list_of_groups[g_index].all_roles[i].role_name.toString() == list_of_groups[g_index].events_that_group_member_is_part_of[event_index].roles[j])
              {
                bool_for_roles_part_of_event[i]=true;
              }
          }
      }
    super.initState();
  }

  bool value=false;

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

  void _showDialog_for_confirm_delete_account(BuildContext context,String role) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Alert!"),
          content: new Text("Are you sure you want to delete the role $role?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("CANCEL"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
                onPressed: () {Navigator.push(context,
                    MaterialPageRoute(builder: (context) => group_channels(index: g_index,)));},
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
            itemCount: list_of_groups[g_index].all_roles.length,
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
                                  list_of_groups[g_index].all_roles[k].role_name,
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
                          Checkbox(value: bool_for_roles_part_of_event[k],
                            onChanged: (value) {
                              setState(() {
                                bool_for_roles_part_of_event[k] = value!;
                              });
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
