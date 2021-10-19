import 'package:chat_app_project/models/Groups.dart';
import 'package:chat_app_project/models/channels.dart';
import 'package:chat_app_project/models/message_model.dart';
import 'package:chat_app_project/widgets/Category_selector.dart';
import 'package:chat_app_project/widgets/Category_selector_for_groups.dart';
import 'package:chat_app_project/widgets/Group_members_widget.dart';
import 'package:chat_app_project/widgets/list_of_channels.dart';
import 'package:chat_app_project/widgets/messages_sent_recieved.dart';
import 'package:chat_app_project/widgets/recent_chats_widget.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class group_channels extends StatefulWidget {
  final List<CHANNELS> channels;
  final Groups group;
  group_channels({required this.channels,required this.group});
  @override
  _group_channels_state createState() => _group_channels_state(channels: channels,group: group);
}

class _group_channels_state extends State<group_channels> {
  final List<CHANNELS> channels;
  final Groups group;
  _group_channels_state({required this.channels,required this.group});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
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
                  group_members(members: group.Members ,),
                  list_of_channels(channels: group.group_channels,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
