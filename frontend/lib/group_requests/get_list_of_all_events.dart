import 'dart:convert';
import 'package:chat_app_project/models/Groups.dart';
import 'package:chat_app_project/models/Groups_class_final.dart';
import 'package:chat_app_project/models/dm_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app_project/global_variables.dart';
import '../global_variables.dart';

Future<List<String>> get_list_of_all_events(
    String group_id, int g_index) async {
  String temp_mssg = "";
  list_of_groups[g_index].events_that_group_member_is_part_of = [];
  bool success_var = false;
  String event_name = "";
  String event_description = "";
  String event_date = "";
  String event_id = "";
  List<int> perms_converted = [];
  var list_of_attendees;
  int count = 0;
  Map data_to_be_sent = {'token': jwt_token};
  var body = JsonEncoder().convert(data_to_be_sent);
  print(body);
  var returned_response = await http.post(
      Uri.parse('$global_link/api/events/$group_id/viewEvents'),
      headers: {"Content-Type": "application/json"},
      body: body);

  print(returned_response.body);
  var decoded_retured_response = jsonDecode(returned_response.body);
  print(decoded_retured_response);

  print(returned_response.statusCode);
  if (returned_response.statusCode == 500) {
    return ["false", "Server Failure"];
  } else if (returned_response.statusCode == 200 ||
      returned_response.statusCode == 201) {
    for (var temp_nest in decoded_retured_response['result']) {
      count++;
      var event_var = temp_nest['events'];
      event_name = event_var['name'];
      print(event_name);
      event_description = event_var['description'];
      event_date = event_var['datetime'];
      event_id = event_var['_id'];
      list_of_attendees = event_var['attendees'];
      print(list_of_attendees[0]);
      List<String> roles_attendees = [];
      for (int j = 0; j < list_of_attendees.length; j++) {
        roles_attendees.add(list_of_attendees[j].toString());
      }
      events temp_event = events(
          event_description: event_description,
          event_id: event_id,
          event_name: event_name,
          event_date: event_date,
          roles: roles_attendees);
      list_of_groups[g_index]
          .events_that_group_member_is_part_of
          .add(temp_event);
      print("1");
      print(list_of_groups[g_index]
          .events_that_group_member_is_part_of[0]
          .event_description);
      print("length");
      print(count);
    }

    return ["true", "success"];
  } else {
    return ["false", "retreiva of roles failed"];
  }
}
