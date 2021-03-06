import 'package:chat_app_project/group_requests/sending_edit_role_permissions.dart';
import 'package:chat_app_project/models/Groups_class_final.dart';
import 'package:chat_app_project/pages/show_roles.dart';
import 'package:chat_app_project/widgets/List_of_roles.dart';
import 'package:chat_app_project/widgets/permisssion_for_a_particular_role.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class edit_roles_and_permissions extends StatefulWidget {
  int g_index;
  int role_index;
  edit_roles_and_permissions({required this.g_index,required this.role_index});

  @override
  _edit_roles_and_permissionsState createState() => _edit_roles_and_permissionsState(g_index: g_index,role_index: role_index);
}

class _edit_roles_and_permissionsState extends State<edit_roles_and_permissions> {
  int curr_index=0;
  int g_index;
  int role_index;
  _edit_roles_and_permissionsState({required this.g_index,required this.role_index});
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
         List<String> response_from_API = await send_edited_permissions_for_role(list_of_groups[g_index].all_roles[role_index].role_name, value1, list_of_groups[g_index].group_id);
        Navigator.push(context,
             MaterialPageRoute(builder: (context) => show_roles(g_index: g_index,)));
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
          "Permissions",
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

                  permission_for_a_particular_role(g_index: g_index,role_index: role_index,),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
