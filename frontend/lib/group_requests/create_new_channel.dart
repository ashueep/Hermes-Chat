import 'dart:convert';
import 'package:chat_app_project/models/Groups.dart';
import 'package:chat_app_project/models/Groups_class_final.dart';
import 'package:chat_app_project/models/dm_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app_project/global_variables.dart';
import '../global_variables.dart';

Future<List<String>> create_new_channel_request(
    String g_id, String group_name) async {
  String temp_mssg = "";
  bool success_var = false;
  Map data_to_be_sent = {
    'token': jwt_token,
    'chaName': group_name, /*'view':["Everyone","Admin"],*/
  };
  var body = JsonEncoder().convert(data_to_be_sent);
  print(body);
  var returned_create_new_role_response = await http.post(
      Uri.parse('$global_link/api/channels/$g_id/addChannel'),
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
    return [decoded_retured_response['message'], "false"];
  }
}

Future<List<String>> edit_group_request_not(
    String group_name, String edited_group_name) async {
  String temp_mssg = "";
  bool success_var = false;
  Map data_to_be_sent = {'token': jwt_token, 'name': group_name};
  var body = JsonEncoder().convert(data_to_be_sent);
  print(body);
  var returned_create_new_role_response = await http.post(
      Uri.parse('$global_link/api/conversations/create'),
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
    return [decoded_retured_response['message'], "false"];
  }
}

Future<List<String>> delete_channel_request(
    String g_id, String group_name) async {
  String temp_mssg = "";
  bool success_var = false;
  Map data_to_be_sent = {'token': jwt_token, 'chaName': group_name};
  var body = JsonEncoder().convert(data_to_be_sent);
  print(body);
  var returned_create_new_role_response = await http.post(
      Uri.parse('$global_link/api/channels/$g_id/deleteChannel'),
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
    return [decoded_retured_response['message'], "false"];
  }
}
