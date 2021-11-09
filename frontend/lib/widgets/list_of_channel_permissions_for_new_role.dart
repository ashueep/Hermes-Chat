import 'dart:math';

import 'package:chat_app_project/group_requests/getting_bool_values.dart';
import 'package:chat_app_project/models/Groups_class_final.dart';
import 'package:chat_app_project/pages/List_of_roles_with_checkboxes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class list_of_channel_perms_for_new_role extends StatefulWidget {
  int g_index;
  int chan_index;
  list_of_channel_perms_for_new_role({required this.g_index,required this.chan_index});

  @override
  _list_of_channel_perms_for_new_roleState createState() => _list_of_channel_perms_for_new_roleState(g_index: g_index,chan_index: chan_index);
}

class _list_of_channel_perms_for_new_roleState extends State<list_of_channel_perms_for_new_role> {
  int g_index;
  int chan_index;
  _list_of_channel_perms_for_new_roleState({required this.g_index,required this.chan_index});

  List<String> channel_perms=["view permission","write permission","edit permission","delete permission"];
  @override
  List<String> roles=["Teacher","Student","Principal","Administrator"];

  List<String> channel_permissions=["view messages","send messages","edit channel","delete channel"];

  List<bool> value1=[false,false,false,false];

  bool value=false;

  List<Color> colors=[Colors.lightBlue,Colors.lightBlueAccent,Colors.lightGreen,Colors.lightGreenAccent,Colors.lime,Colors.limeAccent];

  @override

  Widget _buildNewRoleBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          print("add new role button pressed");
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'ADD NEW ROLE',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  // void _showDialog_for_confirm_delete_account(BuildContext context,String role) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: new Text("Alert!"),
  //         content: new Text("Are you sure you want to delete the role $role?"),
  //         actions: <Widget>[
  //           new FlatButton(
  //             child: new Text("CANCEL"),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           new FlatButton(
  //               onPressed: () {Navigator.push(context,
  //                   MaterialPageRoute(builder: (context) => Group_Page()));},
  //               child: new Text("YES"))
  //         ],
  //       );
  //     },
  //   );
  // }

  Color _choose_random_color(){
    Random random = new Random();
    int randomNumber = random.nextInt(6) + 0;
    return colors[randomNumber];
  }

  Future<List<String>> send_details(String perm_name) async{
    List<String> response_from_API = await get_roles_associated_with_permissions(list_of_groups[g_index].channels_group_member_is_part_of[chan_index].channel_name, perm_name, list_of_groups[g_index].group_id);
    return response_from_API;
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
            itemCount: channel_perms.length,
            itemBuilder: (BuildContext context, int k) {
              return GestureDetector(
                onTap: () async {
                  List<String> response = await send_details(channel_perms[k]);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => list_of_roles_with_checkboxes_page(g_index: g_index,perm_index: k,perm_name: channel_perms[k].toString(),chan_index: chan_index,)));
                },
                child: Container(
                  margin: EdgeInsets.only(
                    top: 5.0,
                    bottom: 5.0,
                    right: 10.0,
                  ),
                  padding:
                  EdgeInsets.symmetric(horizontal: 7.5, vertical: 10.0),
                  decoration: BoxDecoration(
                      color: _choose_random_color(),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [
                          SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.50,
                                child: Text(
                                  channel_perms[k],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(''),
                          Text(''),
                          Text(''),
                          SizedBox(height: 2.5),
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
