import 'dart:convert';
import 'package:chat_app_project/models/Groups.dart';
import 'package:chat_app_project/models/Groups_class_final.dart';
import 'package:chat_app_project/models/dm_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app_project/global_variables.dart';
import '../global_variables.dart';

Future<List<String>> edit_event_members_request(
    String event_id, String group_id, List<String> role_names) async {
  String temp_mssg = "";
  bool success_var = false;
  Map data_to_be_sent = {
    'token': jwt_token,
    'id': event_id,
    'attendees': role_names
  };
  var body = JsonEncoder().convert(data_to_be_sent);
  print(body);
  var returned_create_new_role_response = await http.post(
      Uri.parse('$global_link/api/events/$group_id/updateEvent'),
      headers: {"Content-Type": "application/json"},
      body: body);

  print(returned_create_new_role_response.body);
  var decoded_retured_response =
      jsonDecode(returned_create_new_role_response.body);
  print(decoded_retured_response);

  print(returned_create_new_role_response.statusCode);
  if (returned_create_new_role_response.statusCode == 500) {
    return ["Server Failure", "false"];
  } else if (returned_create_new_role_response.statusCode == 200 ||
      returned_create_new_role_response.statusCode == 201) {
    return ["success", "true"];
  } else {
    return ["failure", "false"];
  }
}

Future<List<String>> edit_event_details_request(
    String event_id,
    String group_id,
    String event_name,
    String event_description,
    String event_date) async {
  String temp_mssg = "";
  bool success_var = false;
  Map data_to_be_sent = {
    'token': jwt_token,
    'id': event_id,
    'name': event_name,
    'description': event_description,
    'datetime': event_date
  };
  var body = JsonEncoder().convert(data_to_be_sent);
  print(body);
  var returned_create_new_role_response = await http.post(
      Uri.parse('$global_link/api/events/$group_id/updateEvent'),
      headers: {"Content-Type": "application/json"},
      body: body);

  print(returned_create_new_role_response.body);
  var decoded_retured_response =
      jsonDecode(returned_create_new_role_response.body);
  print(decoded_retured_response);

  print(returned_create_new_role_response.statusCode);
  if (returned_create_new_role_response.statusCode == 500) {
    return ["Server Failure", "false"];
  } else if (returned_create_new_role_response.statusCode == 200 ||
      returned_create_new_role_response.statusCode == 201) {
    return ["success", "true"];
  } else {
    return ["failure", "false"];
  }
}
