import 'dart:convert';
import 'package:chat_app_project/models/Groups.dart';
import 'package:chat_app_project/models/Groups_class_final.dart';
import 'package:chat_app_project/models/dm_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app_project/global_variables.dart';
import '../global_variables.dart';

Future<List<String>> create_new_role(String name, List<bool> permissions, String group_id) async {
  String temp_mssg = "";
  bool success_var=false;
  List<int> perms_converted=[];
  for(int i=0;i<permissions.length;i++)
    {
      if(permissions[i]==true)
        {
          perms_converted.add(i+1);
        }
    }
  Map data_to_be_sent = {'token': jwt_token,'name': name,'groupPermissions': perms_converted};
  var body = JsonEncoder().convert(data_to_be_sent);
  print(body);
  var returned_create_new_role_response = await http.post(
      Uri.parse('$global_link/api/roles/$group_id/addRole'),
      headers: {"Content-Type": "application/json"},
      body: body);

  print(returned_create_new_role_response.body);
  var decoded_retured_response = jsonDecode(returned_create_new_role_response.body);
  print(decoded_retured_response);

  print(returned_create_new_role_response.statusCode);
  if(returned_create_new_role_response.statusCode==500)
  {
    return ["false","Server Failure"];
  }

  else if(returned_create_new_role_response.statusCode==200 || returned_create_new_role_response.statusCode==201 && decoded_retured_response['success']==true){
    temp_mssg=decoded_retured_response['message'];
    success_var=decoded_retured_response['success'];

    return [temp_mssg,success_var.toString()];
  }

  else
    {
      return [temp_mssg,success_var.toString()];
    }



}