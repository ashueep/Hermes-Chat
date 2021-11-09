import 'package:chat_app_project/global_variables.dart';
import 'package:chat_app_project/group_member_requests/receive_all_roles_part_of_channel.dart';
import 'package:chat_app_project/group_requests/create_new_channel.dart';
import 'package:chat_app_project/models/Groups.dart';
import 'package:chat_app_project/models/Groups_class_final.dart';
import 'package:chat_app_project/models/channels.dart';
import 'package:chat_app_project/models/dm_model.dart';
import 'package:chat_app_project/models/get_all_channel_messages.dart';
import 'package:chat_app_project/models/message_model.dart';
import 'package:chat_app_project/pages/Channel_chat_window.dart';
import 'package:chat_app_project/pages/Groups_Page.dart';
import 'package:chat_app_project/pages/User_dashboard.dart';
import 'package:chat_app_project/pages/add_channel_permissions_for_new_role_page.dart';
import 'package:chat_app_project/pages/chat_window.dart';
import 'package:chat_app_project/pages/group_channels.dart';
import 'package:flutter/material.dart';

class list_of_channels extends StatelessWidget {
  int index;
  list_of_channels({required this.index});
  void _showDialog_for_confirm_delete_account(BuildContext context,String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Alert!"),
          content: new Text("$text"),
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
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 250.0, //just used to test
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
            itemCount: list_of_groups[index].channels_group_member_is_part_of.length,
            itemBuilder: (BuildContext context, int k) {
              return GestureDetector(
                onTap: () async {
                  List<String> response_from_API = await fetch_channel_List(jwt_token, list_of_groups[index].group_id, list_of_groups[index].channels_group_member_is_part_of[k].channel_name.toString(), index, k);
                     Navigator.push(
                     context,
                     MaterialPageRoute(
                         builder: (_) => channel_chat_window(iter: 0, g_index: index, channel_index: k,can_write: can_write.toString(),)));},
                child: Container(
                  margin: EdgeInsets.only(
                    top: 5.0,
                    bottom: 5.0,
                    right: 20.0,
                  ),
                  padding:
                  EdgeInsets.symmetric(horizontal: 7.5, vertical: 10.0),
                  decoration: BoxDecoration(
                      color: Color(0xFFFFEFEE),
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
                            AssetImage('assets/images/channels_icon.png'),
                          ),
                          SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.50,
                                child: Text(
                                  list_of_groups[index].channels_group_member_is_part_of[k].channel_name,
                                  style: TextStyle(
                                    color: Colors.grey,
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
                          list_of_groups[index].channels_group_member_is_part_of[k].channel_name.toString() != "general" ?
                          PopupMenuButton(itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                value: 'edit name',
                                child: Text('Edit Channel Name',style: TextStyle(fontWeight: FontWeight.bold),),
                              ),

                              PopupMenuItem(
                                value: 'edit permissions',
                                child: Text('Edit Channel Permissions',style: TextStyle(fontWeight: FontWeight.bold),),
                              ),

                              PopupMenuItem(
                                value: 'delete',
                                child: Text('Delete Channel', style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                            ];
                          },
                            onSelected: (String value) async {
                              if(value=='edit name'){
                                print("edit value pressed");
                              }

                              else if(value=="edit permissions"){
                                List<String> response_from_API = await request_for_roles(list_of_groups[index].group_id, list_of_groups[index].channels_group_member_is_part_of[k].channel_name, index,k);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => add_channel_perms_for_new_role(g_index: index,chan_index: k,)));
                              }

                              else if(value=='delete')
                              {
                                List<String> response_from_API = await delete_channel_request(list_of_groups[index].group_id, list_of_groups[index].channels_group_member_is_part_of[k].channel_name);
                                response_from_API[1] == "true" ?
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => User_dashboard())) : _showDialog_for_confirm_delete_account(context,response_from_API[0]);
                               
                              }
                            },
                          ) : Text(""),
                          SizedBox(height: 5.0),

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
