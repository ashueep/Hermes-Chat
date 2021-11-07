// ignore_for_file: camel_case_types, file_names

import 'package:chat_app_project/group_requests/receive_list_of_groups.dart';
import 'package:chat_app_project/pages/Groups_Page.dart';
import 'package:chat_app_project/pages/User_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategorySelector extends StatefulWidget {
  @override
  _Curr_state createState() => _Curr_state();
}

class _Curr_state extends State<CategorySelector> {
  int curr_index = 0;
  final List<String> diff_pages = [
    'Direct Messages',
    'Groups',
    'Online',
    'Favourite Contacts'
  ];

  void _showDialog_for_getting_Groups_list_failure(BuildContext context,String message) {
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
    return Container(
      height: 75.0,
      color: Colors.red,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: diff_pages.length,
        itemBuilder: (BuildContext context, int i) {
          return GestureDetector(
            onTap: () async {
              List<String> response_from_API = await receive_list_of_groups();
              if (response_from_API[0] == "true") {
                setState(() {
                  curr_index = i;
                  curr_index == 1
                      ? Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Group_Page()))
                      : Text("");
                });
              }
              else{
                _showDialog_for_getting_Groups_list_failure(context, response_from_API[1]);
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              child: Text(
                diff_pages[i],
                style: TextStyle(
                  color: i == curr_index ? Colors.white : Colors.white60,
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
