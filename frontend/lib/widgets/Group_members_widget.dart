import 'package:chat_app_project/models/message_model.dart';
import 'package:chat_app_project/models/user_model.dart';
import 'package:chat_app_project/pages/chat_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class group_members extends StatelessWidget {
  final List<USER> members;
  group_members({required this.members});
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
                  'Group Members',
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
              itemCount: members.length,
              itemBuilder: (BuildContext context, int j) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              Chat_Window(person1: members[j]))),
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
                          members[j].name,
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
