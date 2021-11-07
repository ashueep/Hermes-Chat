import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'Groups_Page.dart';

List<bool> value2=[];

class add_permissions_for_new_role extends StatefulWidget {
  int g_index;
  add_permissions_for_new_role({required this.g_index});

  @override
  _add_permissions_for_new_roleState createState() => _add_permissions_for_new_roleState(g_index: g_index);
}

class _add_permissions_for_new_roleState extends State<add_permissions_for_new_role> {
  int g_index;
  _add_permissions_for_new_roleState({required this.g_index});
  @override
  List<String> roles=["Teacher","Student","Principal","Administrator"];

  List<String> group_permissions=["add channels","add/modify/delete roles","add/remove members","Add/delete/edit events"];

  void initState()
  {
    value2=[false,false,false,false,false];
    super.initState();
  }

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
            itemCount: group_permissions.length,
            itemBuilder: (BuildContext context, int k) {
              return GestureDetector(
                onTap: () {print("role pressed");},
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
                                  group_permissions[k],
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
                          Checkbox(value: value2[k],
                            onChanged: (value) {
                              setState(() {
                                value2[k] = value!;
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
