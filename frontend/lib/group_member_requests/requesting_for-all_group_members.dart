import 'dart:convert';
import 'package:chat_app_project/models/Groups.dart';
import 'package:chat_app_project/models/Groups_class_final.dart';
import 'package:chat_app_project/models/dm_model.dart';
import 'package:chat_app_project/widgets/list_of_group_members.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app_project/global_variables.dart';
import '../global_variables.dart';

Future<List<String>> fetch_all_members_of_a_group(String group_id,int g_index) async {
  String temp_mssg = "";
  bool success_var = false;
  var list_of_roles;
  String role_name="";
  var group_permissions_list;
  String member_id;
  String member_name;
  String member_username;
  list_of_groups[g_index].members=[];
  Map data_to_be_sent = {'token': jwt_token};
  var body = JsonEncoder().convert(data_to_be_sent);
  print(body);
  var returned_all_roles_response = await http.post(
      Uri.parse('$global_link/api/members/$group_id/viewAll'),
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
    var member_list;
    member_list=decoded_retured_response['members'];
    for(var member in member_list)
      {
        List<String> member_roles_in_string=[];
        //member_id = member['id'];
        member_username=member['username'];
        print(member_username);
        var member_roles = member['roles'];
        for(int i=0;i<member_roles.length;i++)
          {
            member_roles_in_string.add(member_roles[i].toString());
            print(member_roles[i].toString());
          }
        members_class temp_one_member = members_class(member_id: "", member_username: member_username, member_full_name: "", member_roles: member_roles_in_string);
        print(temp_one_member.member_username);
        print(temp_one_member.member_roles.length);
        list_of_groups[g_index].members.add(temp_one_member);
      }
    return ["true","success"];
  }

  else
    {
      return ["false",decoded_retured_response['message']];
    }

}