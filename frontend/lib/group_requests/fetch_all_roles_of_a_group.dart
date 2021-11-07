import 'dart:convert';
import 'package:chat_app_project/models/Groups.dart';
import 'package:chat_app_project/models/Groups_class_final.dart';
import 'package:chat_app_project/models/dm_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app_project/global_variables.dart';
import '../global_variables.dart';

Future<List<String>> fetch_all_roles_of_a_group(
    String group_id, int g_index) async {
  String temp_mssg = "";
  bool success_var = false;
  var list_of_roles;
  String role_name = "";
  var group_permissions_list;
  Map data_to_be_sent = {'token': jwt_token};
  var body = JsonEncoder().convert(data_to_be_sent);
  print(body);
  var returned_all_roles_response = await http.post(
      Uri.parse('$global_link/api/roles/$group_id/getAll'),
      headers: {"Content-Type": "application/json"},
      body: body);

  print(returned_all_roles_response.body);
  var decoded_retured_response = jsonDecode(returned_all_roles_response.body);
  print(decoded_retured_response);

  print(returned_all_roles_response.statusCode);
  if (returned_all_roles_response.statusCode == 500) {
    return ["false", "Server Failure"];
  } else if (returned_all_roles_response.statusCode == 200 ||
      returned_all_roles_response.statusCode == 201 &&
          decoded_retured_response['success'] == true) {
    list_of_groups[g_index].all_roles = [];
    temp_mssg = decoded_retured_response['message'];
    list_of_roles = decoded_retured_response['roles'];
    for (var role_var in list_of_roles) {
      var channel_permissions;
      role_name = role_var['name'];
      print(role_name);
      group_permissions_list = role_var['groupPermissions'];
      print("1");
      channel_permissions = role_var['channelPermissions'];
      String channel_name;
      var channel_list_of_perms;
      List<bool> temp_perms_group_bool = [false, false, false, false, false];
      print("2");
      for (var group_perms_var in group_permissions_list) {
        print("printing iterator for groups permissions");
        print(group_perms_var);
        temp_perms_group_bool[group_perms_var - 1] = true;
      }

      group_permissions temp_group_permissions = group_permissions(
          add_channel: temp_perms_group_bool[0],
          add_modify_delete_roles: temp_perms_group_bool[1],
          add_remove_members: temp_perms_group_bool[2],
          add_edit_delete_events: temp_perms_group_bool[3],
          delete_group: temp_perms_group_bool[4]);
      List<channels_permissions> list_for_chan_perms = [];
      for (var channel_perm in channel_permissions) {
        List<bool> converted_channel_perms = [false, false, false, false];
        channel_name = channel_perm['chaName'];
        channel_list_of_perms = channel_perm['permissions'];
        for (var temp in channel_list_of_perms) {
          print(temp);
          converted_channel_perms[temp - 1] = true;
        }
        channels_permissions chan = channels_permissions(
            channel_name: channel_name,
            view_perm: converted_channel_perms[0],
            write_perm: converted_channel_perms[1],
            edit_perm: converted_channel_perms[2],
            delete_channel_perm: converted_channel_perms[3]);
        list_for_chan_perms.add(chan);
      }
      role temp_role = role(
          role_name: role_name,
          group_permissions_for_role: temp_group_permissions,
          channel_permissions_for_role: list_for_chan_perms);
      list_of_groups[g_index].all_roles.add(temp_role);
    }

    return ["true", decoded_retured_response['message']];
  } else {
    return ["false", decoded_retured_response['message']];
  }
}
