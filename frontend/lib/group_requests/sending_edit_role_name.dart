import 'dart:convert';
import 'package:chat_app_project/models/Groups.dart';
import 'package:chat_app_project/models/Groups_class_final.dart';
import 'package:chat_app_project/models/dm_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app_project/global_variables.dart';
import '../global_variables.dart';

Future<List<String>> send_edited_name_for_role(
    String role_name, String old_name, String group_id) async {
  String temp_mssg = "";
  bool success_var = false;
  List<int> perms_data = [];

  Map data_to_be_sent = {
    'token': jwt_token,
    'name': old_name,
    'newname': role_name,
  };
  var body = JsonEncoder().convert(data_to_be_sent);
  print(body);
  var returned_response = await http.post(
      Uri.parse('$global_link/api/roles/$group_id/editRole'),
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
    temp_mssg = decoded_retured_response['message'];
    success_var = decoded_retured_response['success'];
    return [success_var.toString(), temp_mssg];
  } else {
    return ["false", decoded_retured_response['message']];
  }
}
