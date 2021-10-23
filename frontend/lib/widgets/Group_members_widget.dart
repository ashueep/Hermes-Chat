import 'package:chat_app_project/models/message_model.dart';
import 'package:chat_app_project/models/user_model.dart';
import 'package:chat_app_project/pages/chat_window.dart';
import 'package:chat_app_project/pages/show_events.dart';
import 'package:chat_app_project/pages/show_group_members.dart';
import 'package:chat_app_project/pages/show_roles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class group_members extends StatelessWidget {
  final List<USER> members;
  final List<String> group_customizations=["Roles","Events","Group Members"];
  group_members({required this.members});

  void select_group_customization(int k,context)
  {
    if(k==0)
      {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => show_roles()));
      }

    if(k==1)
      {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => show_events()));
      }

    if(k==2)
    {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => show_group_members()));
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
                  'Group Customization',
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
                          backgroundImage: AssetImage(members[j].imageUrl),
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
