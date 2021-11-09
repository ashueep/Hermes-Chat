import 'package:chat_app_project/models/Groups.dart';
import 'package:chat_app_project/models/Groups_class_final.dart';
import 'package:chat_app_project/models/Sending_login_credentials_to_API.dart';
import 'package:chat_app_project/models/message_model.dart';
import 'package:chat_app_project/pages/Groups_Page.dart';
import 'package:chat_app_project/pages/chat_window.dart';
import 'package:chat_app_project/pages/edit_roles_and_permissions.dart';
import 'package:chat_app_project/pages/group_channels.dart';
import 'package:flutter/material.dart';
import 'dart:math';
List<bool> value1=[];
class permission_for_a_particular_role extends StatefulWidget {
  int g_index;
  int role_index;
  permission_for_a_particular_role({required this.g_index, required this.role_index});

  @override
  State<permission_for_a_particular_role> createState() => _permission_for_a_particular_roleState(g_index: g_index,role_index: role_index);
}

class _permission_for_a_particular_roleState extends State<permission_for_a_particular_role> {
  @override
  int g_index;
  int role_index;
  _permission_for_a_particular_roleState({required this.g_index, required this.role_index});

  void initState()
  {
    value1=[list_of_groups[g_index].all_roles[role_index].group_permissions_for_role.add_channel,
    list_of_groups[g_index].all_roles[role_index].group_permissions_for_role.add_modify_delete_roles,
      list_of_groups[g_index].all_roles[role_index].group_permissions_for_role.add_remove_members,
      list_of_groups[g_index].all_roles[role_index].group_permissions_for_role.add_edit_delete_events,
      list_of_groups[g_index].all_roles[role_index].group_permissions_for_role.delete_group,
    ];
    super.initState();
  }
  List<String> roles=["Teacher","Student","Principal","Administrator"];

  List<String> permissions=["add channels","add/modify/delete roles","add/remove members","Add/edit/delete events","edit/Delete group"];

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
            itemCount: permissions.length,
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
                                  permissions[k],
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
                          Checkbox(value: value1[k],
                            onChanged: (value) {
                              setState(() {
                                if(list_of_groups[g_index].all_roles[role_index].role_name!="Admin" && list_of_groups[g_index].all_roles[role_index].role_name!="Everyone") {
                                  value1[k] = value!;
                                }
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
