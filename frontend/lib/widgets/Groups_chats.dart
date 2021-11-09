import 'package:chat_app_project/group_member_requests/receive_all_roles_part_of_channel.dart';
import 'package:chat_app_project/group_requests/delete_group_request.dart';
import 'package:chat_app_project/group_requests/get_list_of_all_channels.dart';
import 'package:chat_app_project/models/Groups.dart';
import 'package:chat_app_project/models/Groups_class_final.dart';
import 'package:chat_app_project/models/get_all_channel_messages.dart';
import 'package:chat_app_project/models/message_model.dart';
import 'package:chat_app_project/pages/Groups_Page.dart';
import 'package:chat_app_project/pages/User_dashboard.dart';
import 'package:chat_app_project/pages/chat_window.dart';
import 'package:chat_app_project/pages/group_channels.dart';
import 'package:flutter/material.dart';

import '../global_variables.dart';

class Groups_chats extends StatelessWidget {
  @override

  void _showDialog_for_confirm_delete_account(BuildContext context,String message,int k) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Alert!"),
          content: new Text(message),
          actions: <Widget>[
            new FlatButton(
              child: new Text("CANCEL"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
                onPressed: () async {
                  List<String> response_from_API = await exit_group_request(list_of_groups[k].group_id);
                  response_from_API[1]=="true" ?
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => User_dashboard())) : _showDialog_for_confirm_failure(context, response_from_API[0]);},
                 child: new Text("YES"))
          ],
        );
      },
    );
  }

  void _showDialog_for_confirm_failure(BuildContext context,String message) {
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

  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 278.0, //just used to test
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28.0),
            topRight: Radius.circular(28.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28.0),
            topRight: Radius.circular(28.0),
          ),
          child: ListView.builder(
            itemCount: list_of_groups.length,
            itemBuilder: (BuildContext context, int k) {
              return GestureDetector(
                onTap: () async {

                  List<String> response_from_API = await get_all_channels(list_of_groups[k].group_id, k);
                  for(int m=0;m<list_of_groups[k].channels_group_member_is_part_of.length;m++)
                  {
                    List<String> response = await fetch_channel_List(jwt_token, list_of_groups[k].group_id, list_of_groups[k].channels_group_member_is_part_of[m].channel_name, k, m);
                  }
                  response_from_API[0]=="true"?
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => group_channels(index: k,))) : _showDialog_for_confirm_delete_account(context,response_from_API[1],k);
                },
                child: Container(
                  margin: EdgeInsets.only(
                    top: 5.0,
                    bottom: 5.0,
                    right: 20.0,
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 7.5, vertical: 10.0),
                  decoration: BoxDecoration(
                      color: true ? Color(0xFFFFEFEE) : Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage:
                                AssetImage('assets/images/groups_icon.jpg.png'),
                          ),
                          SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.50,
                                child: Text(
                                  list_of_groups[k].group_name,
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: 5.0),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          PopupMenuButton(itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                value: 'edit',
                                child: Text('Edit',style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                child: Text('Exit Group', style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                            ];
                          },
                            onSelected: (String value){
                            if(value=='edit'){
                              print("edit value pressed");
                            }
                            else if(value=='delete')
                              {
                                _showDialog_for_confirm_delete_account(context,"Are you sure you want to exit this group?",k);
                              }
                            },
                          ),

                          SizedBox(height: 1.0),
                          false
                              ? Container(
                                  width: 40.0,
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(28.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'NEW',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : Text(''),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
