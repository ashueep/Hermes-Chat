import 'dart:convert';
import 'package:chat_app_project/models/Groups.dart';
import 'package:chat_app_project/models/Groups_class_final.dart';
import 'package:chat_app_project/models/dm_model.dart';
import 'package:chat_app_project/widgets/list_of_group_members.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app_project/global_variables.dart';
import '../global_variables.dart';

Future<List<String>> delete_group_member(String group_id,int g_index,String member_username) async {
  String temp_mssg = "";
  bool success_var = false;
  var list_of_roles;
  String role_name="";
  var group_permissions_list;
  String member_id;
  String member_name;

  Map data_to_be_sent = {'token': jwt_token,'username': member_username};
  var body = JsonEncoder().convert(data_to_be_sent);
  print(body);
  var returned_all_roles_response = await http.post(
      Uri.parse('$global_link/api/members/$group_id/deleteMember'),
      headers: {"Content-Type": "application/json"},
      body: body);

  print(returned_all_roles_response.body);
  var decoded_retured_response = jsonDecode(returned_all_roles_response.body);
  print(decoded_retured_response);

  print(returned_all_roles_response.statusCode);
  if(returned_all_roles_response.statusCode==500)
  {
    return ["false","Server Failure"];
  }

  else if(returned_all_roles_response.statusCode==200 || returned_all_roles_response.statusCode==201 && decoded_retured_response['success']==true) {
    return ["true","success"];
  }

  else
  {
    return ["false",decoded_retured_response['message']];
  }

}