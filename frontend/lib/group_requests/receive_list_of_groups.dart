import 'dart:convert';
import 'package:chat_app_project/models/Groups.dart';
import 'package:chat_app_project/models/Groups_class_final.dart';
import 'package:chat_app_project/models/dm_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app_project/global_variables.dart';
import '../global_variables.dart';

Future<List<String>> receive_list_of_groups() async {
  String temp_mssg = "";
  String g_id = "";
  String group_name = "";
  var temp_list_of_groups;
  bool success_var = false;
  list_of_groups = [];
  Map data_to_be_sent = {'token': jwt_token};
  var body = JsonEncoder().convert(data_to_be_sent);
  print(body);
  var returned_create_new_group_response = await http.post(
      Uri.parse('$global_link/api/conversations/getGroups'),
      headers: {"Content-Type": "application/json"},
      body: body);
  print(returned_create_new_group_response.body);
  var decoded_retured_response =
      jsonDecode(returned_create_new_group_response.body);
  print(decoded_retured_response);

  print(returned_create_new_group_response.statusCode);
  if (returned_create_new_group_response.statusCode == 500) {
    return ["false", "Server Failure"];
  } else if (returned_create_new_group_response.statusCode == 200 ||
      returned_create_new_group_response.statusCode == 201 &&
          decoded_retured_response['success'] == true) {
    temp_mssg = decoded_retured_response['message'];
    temp_list_of_groups = decoded_retured_response['groups'];
    for (var group in temp_list_of_groups) {
      g_id = group['_id'];
      print("hello");
      print(g_id);
      print("");
      group_name = group['name'];
      print(group_name);
      groups_class temp_group = groups_class(
          group_id: g_id,
          user_roles: [],
          group_name: group_name,
          members: [],
          channels_group_member_is_part_of: [],
          events_that_group_member_is_part_of: []);
      list_of_groups.insert(0, temp_group);
    }
    return ["true", temp_mssg];
  } else {
    temp_mssg = decoded_retured_response['message'];
    return ["false", temp_mssg];
  }
}
