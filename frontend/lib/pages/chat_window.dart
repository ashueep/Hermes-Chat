import 'package:chat_app_project/models/message_model.dart';
import 'package:chat_app_project/models/user_model.dart';
import 'package:flutter/material.dart';


class Chat_Window extends StatefulWidget {
  final USER person1;
  Chat_Window({required this.person1});
  @override
  _Chat_WindowState createState() => _Chat_WindowState();
}

class _Chat_WindowState extends State<Chat_Window> {
  var message_sending_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Message> temp_messages=messages;
    _Build_message(Message person1, bool yes_or_no) {
      final Container message = Container(
        margin: yes_or_no
            ? EdgeInsets.only(top: 7.5, bottom: 7.5, left: 79.5)
            : EdgeInsets.only(
          top: 7.5,
          bottom: 7.5,
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 15.0),
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          color: yes_or_no
              ? Theme.of(context).primaryColorLight
              : Color((0xFFFFEFEE)),
          borderRadius: yes_or_no
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
              person1.time,
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
              person1.text,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );

      if (yes_or_no) {
        return message;
      }
      return Row(
        children: <Widget>[
          message,
          IconButton(
            icon: person1.isLiked ? Icon(Icons.star) : Icon(Icons.star_border),
            iconSize: 30.0,
            color: Colors.black,
            onPressed: () {
            },
          ),
        ],
      );
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
              onPressed: () {
                setState(() {
                  DateTime now = DateTime.now();
                  print(messages.length);
                  String curr_time=now.hour.toString() + ":" + now.minute.toString();
                  Message send_message= Message(sender: currentUser, time: curr_time, text: message_sending_controller.text, isLiked: false, unread: true);
                  print(send_message.text);
                  temp_messages.insert(0,send_message);
                  messages=temp_messages;
                  print(messages.length);
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
        title: Text(widget.person1.name,
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
                    itemCount: temp_messages.length,
                    itemBuilder: (BuildContext context, int l) {
                      return _Build_message(
                          temp_messages[l], temp_messages[l].sender.id == currentUser.id);
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
