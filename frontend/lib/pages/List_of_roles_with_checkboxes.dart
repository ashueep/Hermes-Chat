import 'dart:core';
import 'dart:core';
import 'dart:math';

import 'package:chat_app_project/global_variables.dart';
import 'package:chat_app_project/group_requests/edit_channel_permissions_request_to_API.dart';
import 'package:chat_app_project/group_requests/getting_bool_values.dart';
import 'package:chat_app_project/models/Groups_class_final.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'group_channels.dart';

List<bool> roles_ticked_bool=[];

class list_of_roles_with_checkboxes_page extends StatefulWidget {
  int g_index;
  int chan_index;
  int perm_index;
  String perm_name;
  list_of_roles_with_checkboxes_page({required this.g_index, required this.perm_index,required this.perm_name,required this.chan_index});

  @override
  _list_of_roles_with_checkboxes_pageState createState() => _list_of_roles_with_checkboxes_pageState(g_index: g_index, perm_index: perm_index,perm_name: perm_name,chan_index: chan_index);
}

class _list_of_roles_with_checkboxes_pageState extends State<list_of_roles_with_checkboxes_page> {
  int g_index;
  int perm_index;
  String perm_name;
  int chan_index;
  _list_of_roles_with_checkboxes_pageState({required this.g_index,required this.perm_index,required this.perm_name,required this.chan_index});
  int curr_index=0;

  void _showDialog_for_login_failure(BuildContext context,String message) {
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

  @override
  Widget build(BuildContext context) {

    void onTabTapped(int index) {
      if(index==0)
      {

      }
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          List<String> roles_ticked_by_user = [];
          for(int i=0;i<roles_ticked_bool.length;i++)
            {
              if(roles_ticked_bool[i]==true)
                {
                  roles_ticked_by_user.add(arr_for_chan_perms[i].role_name);
                }
            }
          List<String> response_from_API = await edit_channel_permissions_request(list_of_groups[g_index].channels_group_member_is_part_of[chan_index].channel_name.toString(),list_of_groups[g_index].group_id, perm_name, roles_ticked_by_user);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => group_channels(index: g_index,)));
        },
        child: const Icon(Icons.arrow_forward_ios_outlined),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.orange,
      //   onTap: onTabTapped,
      //   currentIndex: curr_index,
      //   items: [BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined), label: "CONFIRM CHANGES"),
      //     BottomNavigationBarItem(icon: Icon(Icons.arrow_back_ios_new_outlined), label: "RETURN"),
      //   ],
      //
      // ),
      backgroundColor: Colors.red,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: Icon(Icons.more_horiz),
          iconSize: 40.0,
          color: Colors.white,
          onPressed: () {},
        ),
        title: Text(
          "Assign roles",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
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

                  list_of_roles_for_a_particular_permission(g_index: g_index,perm_name: perm_name,chan_index: chan_index,),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class list_of_roles_for_a_particular_permission extends StatefulWidget {
 int g_index;
 String perm_name;
 int chan_index;
 list_of_roles_for_a_particular_permission({required this.g_index,required this.perm_name,required this.chan_index});

  @override
  _list_of_roles_for_a_particular_permissionState createState() => _list_of_roles_for_a_particular_permissionState(g_index: g_index,perm_name: perm_name,chan_index: chan_index);
}

class _list_of_roles_for_a_particular_permissionState extends State<list_of_roles_for_a_particular_permission> {
  @override
  int g_index;
  String perm_name;
  int chan_index;
  _list_of_roles_for_a_particular_permissionState({required this.g_index,required this.perm_name,required this.chan_index});
  List<Color> colors=[Colors.lightBlue,Colors.lightBlueAccent,Colors.lightGreen,Colors.lightGreenAccent,Colors.lime,Colors.limeAccent];

  @override

  void initState(){
    roles_ticked_bool = [];
    print("inside initState of roles");
    //print(list_of_groups[g_index].channels_group_member_is_part_of[chan_index].channel_name);
    //print(list_of_groups[g_index].channels_group_member_is_part_of[chan_index].roles_part_of_channel.length);
    roles_ticked_bool = [];
    for (int i = 0; i <
        arr_for_chan_perms.length; i++) {
      roles_ticked_bool.add(false);
    }
    for (int i = 0; i <
        arr_for_chan_perms.length; i++) {
      roles_ticked_bool[i]=arr_for_chan_perms[i].role_bool;
    }
    print("printing role length");
    print(roles_ticked_bool.length);

  //   for (int i = 0; i < list_of_groups[g_index].all_roles.length; i++) {
  //     if (perm_name == "view permission") {
  //       print("inside view permission");
  //       print("printing chan index");
  //       print(chan_index);
  //       print("length............");
  //       print(list_of_groups[g_index].all_roles[i].channel_permissions_for_role
  //           .length);
  //       if (list_of_groups[g_index].all_roles[i]
  //           .channel_permissions_for_role[chan_index]
  //           .view_perm == true) {
  //         print("inside view permission 1");
  //         print("printing length of roles");
  //         print(list_of_groups[g_index]
  //             .channels_group_member_is_part_of[chan_index]
  //             .roles_part_of_channel.length);
  //         for (int j = 0; j < list_of_groups[g_index]
  //             .channels_group_member_is_part_of[chan_index]
  //             .roles_part_of_channel.length; j++) {
  //           print(list_of_groups[g_index]
  //               .channels_group_member_is_part_of[chan_index]
  //               .roles_part_of_channel[j].toString());
  //           print("and");
  //           print(list_of_groups[g_index].all_roles[i].role_name.toString());
  //           if (list_of_groups[g_index]
  //               .channels_group_member_is_part_of[chan_index]
  //               .roles_part_of_channel[j].toString() ==
  //               list_of_groups[g_index].all_roles[i].role_name.toString()) {
  //             print("inside view permission 2");
  //             roles_ticked_bool[j] = true;
  //           }
  //         }
  //       }
  //     }
  //
  //
  //
  //   if (perm_name == "write permission") {
  //     print("inside write permission");
  //     print(list_of_groups[g_index].all_roles[i]
  //         .channel_permissions_for_role[chan_index]
  //         .write_perm.toString());
  //     if (list_of_groups[g_index].all_roles[i]
  //         .channel_permissions_for_role[0]
  //         .write_perm == true) {
  //       print("inside write permission 1");
  //       print("printing length of roles");
  //       print(list_of_groups[g_index]
  //           .channels_group_member_is_part_of[chan_index]
  //           .roles_part_of_channel.length);
  //       for (int j = 0; j < list_of_groups[g_index]
  //           .channels_group_member_is_part_of[chan_index]
  //           .roles_part_of_channel.length; j++) {
  //         print(list_of_groups[g_index]
  //             .channels_group_member_is_part_of[chan_index]
  //             .roles_part_of_channel[j].toString());
  //         print("and");
  //         print(list_of_groups[g_index].all_roles[i].role_name.toString());
  //         if (list_of_groups[g_index]
  //             .channels_group_member_is_part_of[chan_index]
  //             .roles_part_of_channel[j].toString() ==
  //             list_of_groups[g_index].all_roles[i].role_name.toString()) {
  //           print("inside write permission 2");
  //           roles_ticked_bool[j] = true;
  //         }
  //       }
  //     }
  //   }
  //
  //
  //   if (perm_name == "edit permission") {
  //     print("inside edit permission");
  //     print("printing chan index...");
  //     print(chan_index);
  //     print("printing channel perms for role....");
  //     print(list_of_groups[g_index].all_roles[i]
  //         .channel_permissions_for_role.length);
  //     if (list_of_groups[g_index].all_roles[i]
  //         .channel_permissions_for_role[chan_index]
  //         .edit_perm == true) {
  //       print("inside edit permission 1");
  //       print("printing length of roles");
  //       print(list_of_groups[g_index]
  //           .channels_group_member_is_part_of[chan_index]
  //           .roles_part_of_channel.length);
  //       for (int j = 0; j < list_of_groups[g_index]
  //           .channels_group_member_is_part_of[chan_index]
  //           .roles_part_of_channel.length; j++) {
  //         print(list_of_groups[g_index]
  //             .channels_group_member_is_part_of[chan_index]
  //             .roles_part_of_channel[j].toString());
  //         print("and");
  //         print(
  //             list_of_groups[g_index].all_roles[i].role_name.toString());
  //         if (list_of_groups[g_index]
  //             .channels_group_member_is_part_of[chan_index]
  //             .roles_part_of_channel[j].toString() ==
  //             list_of_groups[g_index].all_roles[i].role_name.toString()) {
  //           print("inside edit permission 2");
  //           roles_ticked_bool[j] = true;
  //         }
  //       }
  //     }
  //     else
  //       {
  //         print("inside else... ");
  //       }
  //   }
  //
  //
  //   if (perm_name == "delete permission") {
  //     print("inside delete permission");
  //     if (list_of_groups[g_index].all_roles[i]
  //         .channel_permissions_for_role[chan_index]
  //         .delete_channel_perm == true) {
  //       print("inside delete permission 1");
  //       print("printing length of roles");
  //       print(list_of_groups[g_index]
  //           .channels_group_member_is_part_of[chan_index]
  //           .roles_part_of_channel.length);
  //       for (int j = 0; j < list_of_groups[g_index]
  //           .channels_group_member_is_part_of[chan_index]
  //           .roles_part_of_channel.length; j++) {
  //         print(list_of_groups[g_index]
  //             .channels_group_member_is_part_of[chan_index]
  //             .roles_part_of_channel[j].toString());
  //         print("and");
  //         print(
  //             list_of_groups[g_index].all_roles[i].role_name.toString());
  //         if (list_of_groups[g_index]
  //             .channels_group_member_is_part_of[chan_index]
  //             .roles_part_of_channel[j].toString() ==
  //             list_of_groups[g_index].all_roles[i].role_name.toString()) {
  //           print("inside delete permission 2");
  //           roles_ticked_bool[j] = true;
  //         }
  //       }
  //     }
  //   }
  // }




    print(list_of_groups[g_index].all_roles.length);
    print("finishing...");
    super.initState();
  }


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
            itemCount: arr_for_chan_perms.length,
            itemBuilder: (BuildContext context, int k) {
              return GestureDetector(
                onTap: () async {

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
                                  arr_for_chan_perms[k].role_name,
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
                          Checkbox(value: roles_ticked_bool[k],
                            onChanged: (value) {
                              setState(() {
                                if(arr_for_chan_perms[k].role_name!="Admin")
                                roles_ticked_bool[k] = value!;
                              });
                            },
                          ),
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

