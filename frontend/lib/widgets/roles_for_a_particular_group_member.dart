import 'dart:math';

import 'package:chat_app_project/models/Groups_class_final.dart';
import 'package:chat_app_project/pages/Groups_Page.dart';
import 'package:chat_app_project/widgets/list_of_group_members.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<bool> bool_value_for_roles_of_group_member=[];

class roles_for_a_particular_group_member extends StatefulWidget {
  int g_index;
  int role_index;
  roles_for_a_particular_group_member({required this.g_index,required this.role_index});

  @override
  _roles_for_a_particular_group_memberState createState() => _roles_for_a_particular_group_memberState(g_index: g_index,role_index: role_index);
}

class _roles_for_a_particular_group_memberState extends State<roles_for_a_particular_group_member> {

  @override
  int g_index;
  int role_index;
  _roles_for_a_particular_group_memberState({required this.g_index, required this.role_index});

  void initState()
  {
    bool_value_for_roles_of_group_member=[];
    for(int i=0;i<list_of_groups[g_index].all_roles.length;i++)
      {
        bool_value_for_roles_of_group_member.add(false);
      }

    for(int i=0;i<list_of_groups[g_index].all_roles.length;i++)
      {
        for(int j=0;j<list_of_groups[g_index].members[role_index].member_roles.length;j++)
          {
            if(list_of_groups[g_index].all_roles[i].role_name.toString()==list_of_groups[g_index].members[role_index].member_roles[j].toString())
              {
                bool_value_for_roles_of_group_member[i]=true;
              }
          }
      }
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
                          Checkbox(value: bool_value_for_roles_of_group_member[k],
                            onChanged: (value) {
                              setState(() {
                                  bool_value_for_roles_of_group_member[k] = value!;
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
