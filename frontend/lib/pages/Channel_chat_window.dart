import 'dart:convert';

import 'package:chat_app_project/models/Groups_class_final.dart';
import 'package:chat_app_project/models/dm_model.dart';
import 'package:chat_app_project/models/recv_class_for_messg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../global_variables.dart';

class channel_chat_window extends StatefulWidget {
  int g_index;
  int channel_index;
  int iter;
  String can_write;
  channel_chat_window(
      {required this.iter,
      required this.g_index,
      required this.channel_index,
      required this.can_write});

  @override
  _channel_chat_windowState createState() => _channel_chat_windowState(
      iter: iter,
      g_index: g_index,
      channel_index: channel_index,
      can_write: can_write);
}

class _channel_chat_windowState extends State<channel_chat_window> {
  final int iter;
  int g_index;
  int channel_index;
  String can_write;
  _channel_chat_windowState(
      {required this.iter,
      required this.g_index,
      required this.channel_index,
      required this.can_write});
  var message_sending_controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    initSocket();
    print("hi");
    print(list_of_groups[g_index]
        .channels_group_member_is_part_of[channel_index]
        .channel_mssgs
        .length);
  }

  void initSocket() {
    IO.Socket socket_for_channel = IO.io('$global_link/', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    print("hello");
    socket_for_channel.connect();
    print(socket_for_channel.connected);
    socket_for_channel.onConnect((_) {
      print("connected to websocket for channel");
    });
    //   var DM_var={'dmid': list_of_DMs[iter].DM_id};
    //   json.encode(DM_var);
    //   socket.emit('connectDM',DM_var);
    //   socket.on('recvDM',(data){
    //     Map<String,dynamic> body = json.decode(data);
    //     setState(() {
    //       list_of_DMs[iter].messages.add(updated_mssg_model(sender_username: body['sender_username'], text_message: body['body'], time_stamp: body['timestamp']));
    //     });
    //   });
    //
    // }
    String g_id = list_of_groups[g_index].group_id;
    String channel_name = list_of_groups[g_index]
        .channels_group_member_is_part_of[channel_index]
        .channel_name;
    var connect_var = {'room': "$g_id-$channel_name"};
    json.encode(connect_var);
    socket_for_channel.emit('connectChan', connect_var);
    socket_for_channel.on('recvChan', (data) {
      print("inside receive chan");
      // Map<String,dynamic> body = json.decode(data);
      // print(data);
      // setState(() {
      //   channel_messages temp_message = channel_messages(sent_by: body['senderID'], body_text: body['body'], timestamp: body['timestamp']);
      //   print(body);
      //   list_of_groups[g_index].channels_group_member_is_part_of[channel_index].channel_mssgs.add(temp_message);
      // });
    });
  }

  void dispose() {
    //socket.emit('disconnectDM');
    super.dispose();
  }

  void send_message(String text) {
    IO.Socket socket_for_sending = IO.io('$global_link/', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket_for_sending.connect();
    print(socket_for_sending.connected);
    if (text != '') {
      String g_id = list_of_groups[g_index].group_id;
      print("sending message");
      String channel_name = list_of_groups[g_index]
          .channels_group_member_is_part_of[channel_index]
          .channel_name;
      var messg_to_post = {
        'room': "$g_id-$channel_name",
        'sender': username_of_current_user,
        'text': text,
      };
      json.encode(messg_to_post);
      print(messg_to_post);
      socket_for_sending.emit('sendChan', messg_to_post);
      setState(() {
        print("inside set state");
        list_of_groups[g_index]
            .channels_group_member_is_part_of[channel_index]
            .channel_mssgs
            .insert(
                0,
                channel_messages(
                    sent_by: members_class(
                        member_id: "",
                        member_username: username_of_current_user,
                        member_full_name: "",
                        member_roles: []),
                    body_text: message_sending_controller.text.toString(),
                    timestamp: "2:40"));
      });
    }
  }

  Widget build(BuildContext context) {
    _Build_message(channel_messages mssg, bool is_user) {
      bool yes_or_no = true;
      final Container message = Container(
        margin: is_user
            ? EdgeInsets.only(top: 7.5, bottom: 7.5, left: 79.5)
            : EdgeInsets.only(
                top: 7.5,
                bottom: 7.5,
              ),
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 15.0),
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          color: is_user
              ? Theme.of(context).primaryColorLight
              : Color((0xFFFFEFEE)),
          borderRadius: is_user
              ? BorderRadius.only(
                  topLeft: Radius.circular(18.0),
                  bottomLeft: Radius.circular(18.0),
                )
              : BorderRadius.only(
                  bottomRight: Radius.circular(18.0),
                  topRight: Radius.circular(18.0),
                ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              mssg.sent_by.member_username,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 7.5,
            ),
            Text(
              mssg.body_text,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );

      if (true) {
        return message;
      }
      /*return Row(
        children: <Widget>[
          message,
          IconButton(
            icon: true ? Icon(Icons.star) : Icon(Icons.star_border),
            iconSize: 30.0,
            color: Colors.black,
            onPressed: () {
            },
          ),
        ],
      );*/
    }

    _buildMessageSendingBar() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        height: 70.0,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.photo),
              iconSize: 24.5,
              color: Theme.of(context).primaryColor,
              onPressed: () {},
            ),
            Expanded(
                child: TextField(
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(hintText: 'Type Your Message'),
              controller: message_sending_controller,
            )),
            IconButton(
              icon: Icon(Icons.send),
              iconSize: 24.5,
              color: Theme.of(context).primaryColor,
              onPressed: () async {
                send_message(message_sending_controller.text);
                setState(() {
                  print("trying to update messages");
                });
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text(
            list_of_groups[g_index]
                .channels_group_member_is_part_of[channel_index]
                .channel_name,
            style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold)),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            iconSize: 40.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(28.0),
                      topRight: Radius.circular(28.0)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(28.0),
                      topRight: Radius.circular(28.0)),
                  child: ListView.builder(
                    reverse: true,
                    padding: EdgeInsets.only(top: 15.0),
                    itemCount: list_of_groups[g_index]
                        .channels_group_member_is_part_of[channel_index]
                        .channel_mssgs
                        .length,
                    itemBuilder: (BuildContext context, int l) {
                      return _Build_message(
                          list_of_groups[g_index]
                              .channels_group_member_is_part_of[channel_index]
                              .channel_mssgs[l],
                          list_of_groups[g_index]
                                  .channels_group_member_is_part_of[
                                      channel_index]
                                  .channel_mssgs[l]
                                  .sent_by
                                  .member_username ==
                              username_of_current_user);
                    },
                  ),
                ),
              ),
            ),
            can_write == "true" ? _buildMessageSendingBar() : Text(''),
          ],
        ),
      ),
    );
  }
}
