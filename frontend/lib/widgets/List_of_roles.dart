import 'package:chat_app_project/models/Groups.dart';
import 'package:chat_app_project/models/Sending_login_credentials_to_API.dart';
import 'package:chat_app_project/models/message_model.dart';
import 'package:chat_app_project/pages/Groups_Page.dart';
import 'package:chat_app_project/pages/change_role_name_page.dart';
import 'package:chat_app_project/pages/chat_window.dart';
import 'package:chat_app_project/pages/edit_roles_and_permissions.dart';
import 'package:chat_app_project/pages/group_channels.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class list_of_roles extends StatelessWidget {
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
                    MaterialPageRoute(builder: (context) => Group_Page()));},
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
            itemCount: roles.length,
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
                                  roles[k],
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
                          (roles[k].toString()!="Admin" && roles[k].toString()!="Everyone") ?
                            PopupMenuButton(itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  value: 'edit permissions',
                                  child: Text('Edit Role Permissions',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),),
                                ),
                                PopupMenuItem(
                                  value: 'edit role name',
                                  child: Text('Edit Role Permissions',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),),
                                ),
                                PopupMenuItem(
                                  value: 'delete',
                                  child: Text('Delete Role', style: TextStyle(
                                      fontWeight: FontWeight.bold,color: Colors.redAccent),),
                                ),
                              ];
                            },

                              onSelected: (String value) {
                                if (value == 'edit permissions') {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) =>
                                          edit_roles_and_permissions(
                                            g_index: 0, role_index: 0,)));
                                }

                                else if (value == 'edit role name') {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) =>
                                          change_role_name(
                                            curr_role_name: roles[k],
                                            g_index: 0,
                                            index_for_role: 0,)));
                                }

                                else if (value == 'delete') {
                                  _showDialog_for_confirm_delete_account(
                                      context, groups[k].Group_name);
                                }
                              },
                            )
                          : Text(""),


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
