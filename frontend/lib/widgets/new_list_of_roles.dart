import 'dart:math';

import 'package:chat_app_project/group_requests/delete_role.dart';
import 'package:chat_app_project/models/Groups.dart';
import 'package:chat_app_project/models/Groups_class_final.dart';
import 'package:chat_app_project/pages/Groups_Page.dart';
import 'package:chat_app_project/pages/change_role_name_page.dart';
import 'package:chat_app_project/pages/edit_roles_and_permissions.dart';
import 'package:chat_app_project/pages/group_channels.dart';
import 'package:chat_app_project/pages/show_roles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class new_list_of_roles extends StatefulWidget {
  int index;
  new_list_of_roles({required this.index});

  @override
  _new_list_of_rolesState createState() => _new_list_of_rolesState(index: index);
}

class _new_list_of_rolesState extends State<new_list_of_roles> {
  int index;
  _new_list_of_rolesState({required this.index});
  List<String> roles=["Teacher","Student","Principal","Administrator"];
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
          content: new Text("$role as you do not have permission"),
          actions: <Widget>[
            new FlatButton(
                onPressed: () async {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => show_roles(g_index: index,)));
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
            itemCount: list_of_groups[index].all_roles.length,
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
                                  list_of_groups[index].all_roles[k].role_name,
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
                          (list_of_groups[index].all_roles[k].role_name.toString()!="Admin" && list_of_groups[index].all_roles[k].role_name.toString()!="Everyone") ?
                          PopupMenuButton(itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                value: 'edit permissions',
                                child: Text('Edit Role Permissions',style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                              PopupMenuItem(
                                value: 'edit role name',
                                child: Text('Edit Role Name',style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                child: Text('Delete Role', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
                              ),
                            ];
                          },
                            onSelected: (String value) async {
                              if(value=='edit permissions'){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => edit_roles_and_permissions(g_index: index,role_index: k,)));
                              }

                              else if(value=='edit role name')
                              {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => change_role_name(curr_role_name: list_of_groups[index].all_roles[k].role_name,g_index: index,index_for_role: k,)));
                              }

                              else if(value=='delete')
                              {
                                List<String> response_from_API = await delete_role_request(list_of_groups[index].all_roles[k].role_name.toString(),list_of_groups[index].group_id);
                                response_from_API[1]=="true" ?
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => group_channels(index: index,))) : _showDialog_for_confirm_delete_account(context,response_from_API[0]);
                              }
                            },
                          ) : SizedBox.shrink(),

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
