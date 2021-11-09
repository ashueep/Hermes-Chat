import 'package:chat_app_project/models/dm_model.dart';
import 'package:chat_app_project/models/message_model.dart';
import 'package:chat_app_project/pages/chat_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class recent_chats extends StatelessWidget {
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
                  'Recent chats',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
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
              itemCount: list_of_DMs.length,
              itemBuilder: (BuildContext context, int j) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              Chat_Window(iter: j,full_name: list_of_DMs[j].friend.full_name,))),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 34.0,
                          backgroundImage: AssetImage('assets/images/group.jpg.png'),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          list_of_DMs[j].friend.full_name,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
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
