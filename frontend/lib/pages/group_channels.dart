import 'package:chat_app_project/models/Groups.dart';
import 'package:chat_app_project/models/channels.dart';
import 'package:chat_app_project/models/message_model.dart';
import 'package:chat_app_project/pages/create_new_channel.dart';
import 'package:chat_app_project/widgets/Category_selector.dart';
import 'package:chat_app_project/widgets/Category_selector_for_groups.dart';
import 'package:chat_app_project/widgets/group_customisations.dart';
import 'package:chat_app_project/widgets/list_of_channels.dart';
import 'package:chat_app_project/widgets/messages_sent_recieved.dart';
import 'package:chat_app_project/widgets/recent_chats_widget.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class group_channels extends StatefulWidget {

  int index;
  group_channels({required this.index});
  @override
  _group_channels_state createState() => _group_channels_state(index: index);
}

class _group_channels_state extends State<group_channels> {
  int index;
  _group_channels_state({required this.index});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
           Navigator.push(context,
               MaterialPageRoute(builder: (context) => create_new_channel_page(g_index: index)));
        },
        child: const Icon(Icons.add_circle_outline_sharp),
      ),
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          iconSize: 40.0,
          color: Colors.white,
          onPressed: () {},
        ),
        title: Text('Channels',
            style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold)),
        elevation: 0.0,
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
          CategorySelector_for_group(),
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
                  group_members(index: index),
                  list_of_channels(index: index),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
