// ignore_for_file: camel_case_types, file_names

import 'package:chat_app_project/global_variables.dart';
import 'package:chat_app_project/models/getting_DM_List.dart';
import 'package:chat_app_project/pages/Groups_Page.dart';
import 'package:chat_app_project/pages/User_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategorySelector_for_group extends StatefulWidget {
  @override
  _CategorySelector_for_group createState() => _CategorySelector_for_group();
}

class _CategorySelector_for_group extends State<CategorySelector_for_group> {
  int curr_index = 1;
  final List<String> diff_pages = [
    'Direct Messages',
    'Groups',
    'Online',
    'Favourite Contacts'
  ];
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
              final List<String> response = await fetch_DM_List(jwt_token);
              setState(() {
                curr_index = i;
                curr_index == 0
                    ? Navigator.push(context,
                        MaterialPageRoute(builder: (context) => User_dashboard()))
                    : Text("");
              });
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
