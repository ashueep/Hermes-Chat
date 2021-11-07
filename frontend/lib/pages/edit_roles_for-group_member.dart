import 'package:chat_app_project/group_member_requests/edit_roles_for-group_member_request.dart';
import 'package:chat_app_project/models/Groups_class_final.dart';
import 'package:chat_app_project/pages/group_channels.dart';
import 'package:chat_app_project/widgets/roles_for_a_particular_group_member.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class edit_roles_for_a_particular_group_member extends StatefulWidget {
  int g_index;
  int role_index;
  edit_roles_for_a_particular_group_member({required this.g_index, required this.role_index});

  @override
  _edit_roles_for_a_particular_group_memberState createState() => _edit_roles_for_a_particular_group_memberState(g_index: g_index,role_index: role_index);
}

class _edit_roles_for_a_particular_group_memberState extends State<edit_roles_for_a_particular_group_member> {
  int curr_index=0;
  int g_index;
  int role_index;
  _edit_roles_for_a_particular_group_memberState({required this.g_index,required this.role_index});
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
          List<String> roles_updated=[];
          for(int i=0;i<bool_value_for_roles_of_group_member.length;i++)
            {
              if(bool_value_for_roles_of_group_member[i]==true)
                {
                  roles_updated.add(list_of_groups[g_index].all_roles[i].role_name.toString());
                }
            }
          List<String> response_from_API = await edit_members_roles_of_a_group(list_of_groups[g_index].group_id, g_index, list_of_groups[g_index].members[role_index].member_username, roles_updated);
          response_from_API[0]=="true" ?
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => group_channels(index: g_index,))) : _showDialog_for_login_failure(context, response_from_API[0]);
        },
        child: const Icon(Icons.arrow_forward_ios_outlined),
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
          "Roles",
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

                  roles_for_a_particular_group_member(g_index: g_index,role_index: role_index,),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
