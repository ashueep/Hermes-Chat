import 'dart:convert';

import 'package:chat_app_project/global_variables.dart';
import 'package:chat_app_project/models/dm_model.dart';
import 'package:chat_app_project/models/getting_DM_List.dart';
import 'package:chat_app_project/models/message_model.dart';
import 'package:chat_app_project/models/recv_class_for_messg.dart';
import 'package:chat_app_project/models/request_for_list_of_messages_DM.dart';
import 'package:chat_app_project/models/user_model.dart';
import 'package:chat_app_project/pages/User_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Chat_Window extends StatefulWidget {
  final int iter;
  final String full_name;
  Chat_Window({
    required this.iter,
    required this.full_name,
  });
  @override
  _Chat_WindowState createState() => _Chat_WindowState(iter: iter);
}

class _Chat_WindowState extends State<Chat_Window> {
  final int iter;
  _Chat_WindowState({required this.iter});
  var message_sending_controller = TextEditingController();
  IO.Socket? socket;

  @override
  initState(){
    super.initState();
    initSocket();
  }

  Future<void> initSocket() async {
    socket = IO.io('$global_link/', <String,dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    print("hello");
    socket!.connect();
    print(socket!.connected);
    socket!.onConnect((_) {
      print("connected to websocket");
    });
    var DM_var = {'dmid': list_of_DMs[iter].DM_id};
    json.encode(DM_var);
    socket!.emit('connectDM', DM_var);
    print("emitting");
    socket!.on('recvDM', (data) {
      print("test 1......");
      print("test 2........");
      print(data);
      print("this is the type...");
      print(data.runtimeType);
      Map<String,dynamic> body = data;
      print(body);
      print("test 2........");
      setState(() {
        print("inside recvDM sockets part of it!!!!!!");
        String date = body['timestamp'];
        print(date);
        DateTime date_received = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(date, true);
        DateTime local_date = date_received.toLocal();
        String parsed_date = local_date.toString();
        list_of_DMs[iter].messages.insert(0,updated_mssg_model(
            sender_username: body['senderID'],
            text_message: body['body'],
            time_stamp: parsed_date));
      });
    });
  }

  void send_message(String text) {
    // socket_for_sending = IO.io('$global_link/', <String, dynamic>{
    //   'transports': ['websocket'],
    //   'autoConnect': false,
    // });
    // socket_for_sending!.connect();
    if (text != '') {
      var messg_to_post = {
        'room': list_of_DMs[iter].DM_id,
        'sender': username_of_current_user,
        'text': text,
      };
      json.encode(messg_to_post);
      socket!.emit('sendDM', messg_to_post);
      print("sent message");
      setState(() {
        String date_now = DateTime.now().toString();
        updated_mssg_model temp_message = updated_mssg_model(sender_username: username_of_current_user, text_message: text, time_stamp: date_now);
        list_of_DMs[iter].messages.insert(0, temp_message);
      });
    }
  }

  @override
  void dispose() {
    print("socket disconnecting........................................");
    socket!.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<updated_mssg_model>? temp_messages = list_of_DMs[iter].messages;

    _Build_message(updated_mssg_model mssg, bool is_user) {
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
              mssg.time_stamp,
              style: TextStyle(
                color: Colors.black26,
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 7.5,
            ),
            Text(
              mssg.text_message,
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
                  message_sending_controller.text='';
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
        title: Text(list_of_DMs[iter].friend.full_name,
            style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold)),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 30.0,
          color: Colors.white,
          onPressed: () async{
            dispose();
            final List<String> response_for_requesting_DM_List = await fetch_DM_List(jwt_token);
            for(int m=0;m<list_of_DMs.length;m++)
            {
              await request_for_list_of_messages_for_DM(m);
            }
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => User_dashboard()));
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            iconSize: 40.0,
            color: Colors.white,
            onPressed: () {print("horiz button being pressed...");},
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
                    itemCount: temp_messages.length,
                    itemBuilder: (BuildContext context, int l) {
                      return _Build_message(
                          temp_messages[l],
                          temp_messages[l].sender_username ==
                              username_of_current_user);
                    },
                  ),
                ),
              ),
            ),
            _buildMessageSendingBar(),
          ],
        ),
      ),
    );
  }
}
