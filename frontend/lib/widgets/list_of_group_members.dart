import 'dart:math';

import 'package:chat_app_project/group_member_requests/delete_member_reqest.dart';
import 'package:chat_app_project/models/Groups_class_final.dart';
import 'package:chat_app_project/pages/change_role_name_page.dart';
import 'package:chat_app_project/pages/edit_roles_and_permissions.dart';
import 'package:chat_app_project/pages/edit_roles_for-group_member.dart';
import 'package:chat_app_project/pages/group_channels.dart';
import 'package:chat_app_project/pages/show_roles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class list_of_group_members extends StatefulWidget {
  int g_index;
  list_of_group_members({required this.g_index});
  @override
  _list_of_group_membersState createState() => _list_of_group_membersState(g_index: g_index);
}

class _list_of_group_membersState extends State<list_of_group_members> {
  int g_index;
  _list_of_group_membersState({required this.g_index});
  List<String> roles=["Teacher","Student","Principal","Administrator"];
  List<Color> colors=[Colors.lightBlue,Colors.lightBlueAccent,Colors.lightGreen,Colors.lightGreenAccent,Colors.lime,Colors.limeAccent];
  @override

  void _showDialog_for_confirm_delete_account(BuildContext context,String role) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Alert!"),
          content: new Text("$role"),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => group_channels(index: g_index,)));
                },
                child: new Text("OK"))
          ],
        );
      },
    );
  }

  Color _choose_random_color(){
    Random random = new Random();
    int randomNumber = random.nextInt(6) + 0;
    return colors[randomNumber];
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
            itemCount: list_of_groups[g_index].members.length,
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
                                  list_of_groups[g_index].members[k].member_username,
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
                                value: 'edit roles',
                                child: Text('Edit Roles',style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                              PopupMenuItem(
                                value: 'delete member',
                                child: Text('Delete Member', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
                              ),
                            ];
                          },
                            onSelected: (String value) async { //do from here tomorrow
                              if(value=='edit roles'){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => edit_roles_for_a_particular_group_member(g_index: g_index,role_index: k,)));
                              }

                              else if(value=='view roles')
                              {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => change_role_name(curr_role_name: list_of_groups[g_index].all_roles[k].role_name,g_index: g_index,index_for_role: k,)));
                              }

                              else if(value=='delete member')
                              {
                                List<String> response_from_API = await delete_group_member(list_of_groups[g_index].group_id, g_index, list_of_groups[g_index].members[k].member_username);
                                response_from_API[0] == true ?
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) =>group_channels(index: g_index))) : 
                                 _showDialog_for_confirm_delete_account(context, response_from_API[1]);
                                    
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
