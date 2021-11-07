import 'package:chat_app_project/group_member_requests/requesting_for-all_group_members.dart';
import 'package:chat_app_project/group_requests/fetch_all_roles_of_a_group.dart';
import 'package:chat_app_project/group_requests/get_list_of_all_events.dart';
import 'package:chat_app_project/models/Groups_class_final.dart';
import 'package:chat_app_project/models/message_model.dart';
import 'package:chat_app_project/models/user_model.dart';
import 'package:chat_app_project/pages/chat_window.dart';
import 'package:chat_app_project/pages/show_events.dart';
import 'package:chat_app_project/pages/show_group_members.dart';
import 'package:chat_app_project/pages/show_roles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class group_members extends StatelessWidget {
  int index;
  List<IconData> group_customisation_icons=[Icons.task,Icons.event,Icons.groups];
  final List<String> group_customizations=["Roles","Events","Members"];
  group_members({required this.index});
  List<String> group_icons = ['assets/images/roles.jpg.png','assets/images/events.jpg.png','assets/images/group.jpg.png'];

  void select_group_customization(int k,context) async
  {
    if(k==0)
      {
        List<String> response_from_API = await fetch_all_roles_of_a_group(list_of_groups[index].group_id, index);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => show_roles(g_index: index,)));
      }

    if(k==1)
      {
        List<String> response_from_API = await get_list_of_all_events(list_of_groups[index].group_id,index);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => show_events(g_index: index,)));
      }

    if(k==2)
    {List<String> response_from_API=[];

       response_from_API = await fetch_all_members_of_a_group(list_of_groups[index].group_id, index);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => show_group_members(g_index: index,)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Group Customizations',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
                IconButton(
                    icon: Icon(
                      Icons.more_horiz,
                    ),
                    iconSize: 29.0,
                    color: Colors.blueGrey,
                    onPressed: () {}),
              ],
            ),
          ),
          Container(
            height: 120.0,
            child: ListView.builder(
              padding: EdgeInsets.only(left: 10.0),
              scrollDirection: Axis.horizontal,
              itemCount: group_customizations.length,
              itemBuilder: (BuildContext context, int j) {
                return GestureDetector(
                  onTap:
                      () => select_group_customization(j,context),

                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 34.0,
                          backgroundImage: AssetImage(group_icons[j]),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          group_customizations[j],
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
