import 'dart:convert';
import 'package:chat_app_project/models/Groups.dart';
import 'package:chat_app_project/models/Groups_class_final.dart';
import 'package:chat_app_project/models/dm_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app_project/global_variables.dart';
import '../global_variables.dart';

Future<List<String>> request_for_roles(String group_id,String channel_name,int g_index,int chan_index) async {
  String temp_mssg = "";
  bool success_var=false;
  Map data_to_be_sent = {'token': jwt_token,'chaName': channel_name};
  var body = JsonEncoder().convert(data_to_be_sent);
  print(body);
  var returned_create_new_role_response = await http.post(
      Uri.parse('$global_link/api/channels/$group_id/sendAllRolesForChannel/'),
      headers: {"Content-Type": "application/json"},
      body: body);

  print(returned_create_new_role_response.body);
  var decoded_retured_response = jsonDecode(returned_create_new_role_response.body);
  print(decoded_retured_response);

  print(returned_create_new_role_response.statusCode);
  if(returned_create_new_role_response.statusCode==500)
  {
    return ["Server Failure","false"];
  }

  else if(returned_create_new_role_response.statusCode==200 || returned_create_new_role_response.statusCode==201){
    var roles_received = decoded_retured_response['roles_in_chan'];
    print("printed");
    print(roles_received);
    int count=0;
    for(int i=0;i<list_of_groups[g_index].channels_group_member_is_part_of.length;i++) {
      list_of_groups[g_index].channels_group_member_is_part_of[i]
          .roles_part_of_channel=[];
      print("success");
      var chan_role_name = list_of_groups[g_index]
          .channels_group_member_is_part_of[i].channel_name.toString();
      var list_for_each_channel = roles_received['$chan_role_name'];
      for (var role_var in list_for_each_channel) {
        print(role_var);
        list_of_groups[g_index].channels_group_member_is_part_of[i]
            .roles_part_of_channel.add(role_var);
      }
      count++;
    }
    return ["success","true"];
  }

  else
  {
    return [decoded_retured_response['message'],"false"];
  }

}

Future<List<String>> edit_group_request(String group_name,String edited_group_name) async {
  String temp_mssg = "";
  bool success_var=false;
  Map data_to_be_sent = {'token': jwt_token,'name': group_name};
  var body = JsonEncoder().convert(data_to_be_sent);
  print(body);
  var returned_create_new_role_response = await http.post(
      Uri.parse('$global_link/api/conversations/create'),
      headers: {"Content-Type": "application/json"},
      body: body);

  print(returned_create_new_role_response.body);
  var decoded_retured_response = jsonDecode(returned_create_new_role_response.body);
  print(decoded_retured_response);

  print(returned_create_new_role_response.statusCode);
  if(returned_create_new_role_response.statusCode==500)
  {
    return ["Server Failure","false"];
  }

  else if(returned_create_new_role_response.statusCode==200 || returned_create_new_role_response.statusCode==201){
    return ["success","true"];
  }

  else
  {
    return [decoded_retured_response['message'],"false"];
  }

}


Future<List<String>> delete_group_request(String group_name,String edited_group_name) async {
  String temp_mssg = "";
  bool success_var=false;
  Map data_to_be_sent = {'token': jwt_token,'name': group_name};
  var body = JsonEncoder().convert(data_to_be_sent);
  print(body);
  var returned_create_new_role_response = await http.post(
      Uri.parse('$global_link/api/conversations/create'),
      headers: {"Content-Type": "application/json"},
      body: body);

  print(returned_create_new_role_response.body);
  var decoded_retured_response = jsonDecode(returned_create_new_role_response.body);
  print(decoded_retured_response);

  print(returned_create_new_role_response.statusCode);
  if(returned_create_new_role_response.statusCode==500)
  {
    return ["Server Failure","false"];
  }

  else if(returned_create_new_role_response.statusCode==200 || returned_create_new_role_response.statusCode==201){
    return ["success","true"];
  }

  else
  {
    return [decoded_retured_response['message'],"false"];
  }

}