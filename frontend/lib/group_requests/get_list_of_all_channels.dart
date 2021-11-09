import 'dart:convert';
import 'package:chat_app_project/models/Groups.dart';
import 'package:chat_app_project/models/Groups_class_final.dart';
import 'package:chat_app_project/models/dm_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app_project/global_variables.dart';
import '../global_variables.dart';

Future<List<String>> get_all_channels(String group_id, int g_index) async {
  String temp_mssg = "";
  bool success_var = false;
  String temp_channel_name;
  String chan_id;
  list_of_groups[g_index].channels_group_member_is_part_of = [];
  Map data_to_be_sent = {'token': jwt_token};
  var body = JsonEncoder().convert(data_to_be_sent);
  print(body);
  var returned_create_new_role_response = await http.post(
      Uri.parse('$global_link/api/channels/$group_id/viewAll'),
      headers: {"Content-Type": "application/json"},
      body: body);

  print(returned_create_new_role_response.body);
  var decoded_retured_response =
      jsonDecode(returned_create_new_role_response.body);
  print(decoded_retured_response);
  var list_for_chans;
  print(returned_create_new_role_response.statusCode);
  if (returned_create_new_role_response.statusCode == 500) {
    return ["Server Failure", "false"];
  } else if (decoded_retured_response['success'] == true) {
    list_for_chans = decoded_retured_response['channels'];
    for (var chan in list_for_chans) {
      chan_id = chan['_id'];
      temp_channel_name = chan['name'];
      // print(temp_channel_name);
      // print("");
      channels temp_channel = channels(
          channel_id: chan_id,
          channel_name: temp_channel_name,
          channel_mssgs: [],
          roles_part_of_channel: []);
      list_of_groups[g_index]
          .channels_group_member_is_part_of
          .add(temp_channel);
    }
    var list_of_channel_roles = decoded_retured_response['all_roles'];
    String chaName;
    int count = 0;
    list_of_groups[g_index].all_roles = [];
    for (var one_channel_role in list_of_channel_roles) {
      List<bool> group_perm_bool = [false, false, false, false, false];
      temp_channel_name = one_channel_role['name'];
      //print("2");
      //print(temp_channel_name);
      var group_perms = one_channel_role['groupPermissions'];
      //print(group_perms.length);
      for (int j = 0; j < group_perms.length; j++) {
        //print("1");
        group_perm_bool[group_perms[j] - 1] = true;
      }
      List<channels_permissions> list1 = [];
      print(one_channel_role);
      var channel_list = one_channel_role['channelPermissions'];
      print(one_channel_role['channelPermissions'].length);
      print("printing channel size");
      print(channel_list[0]['chaName']);
      print(channel_list.length);

      for (var chan in channel_list) {
        chaName = chan['chaName'];
        var channel_permissions_list = chan['permissions'];
        List<bool> chan_perm_bool = [false, false, false, false];
        for (int i = 0; i < channel_permissions_list.length; i++) {
          print("");
          print(channel_permissions_list[i]);
          print(temp_channel_name);
          print("");
          chan_perm_bool[channel_permissions_list[i] - 1] = true;
          print(temp_channel_name);
          print(chan_perm_bool[0]);
          print(temp_channel_name);
          print(chan_perm_bool[1]);
          print(chan_perm_bool[2]);
          print(chan_perm_bool[3]);
        }
        channels_permissions temp1 = channels_permissions(
            channel_name: chaName,
            view_perm: chan_perm_bool[0],
            write_perm: chan_perm_bool[1],
            edit_perm: chan_perm_bool[2],
            delete_channel_perm: chan_perm_bool[3]);
        if (temp_channel_name == "Everyone") {
          print(temp1.channel_name);
          print("next");
          print(temp1.view_perm);
          print("next");
          print(temp1.write_perm);
          print("next");
          print(temp1.edit_perm);
          print("next");
          print(temp1.delete_channel_perm);
        }

        list1.add(temp1);
      }

      print("size of list 1");
      print(list1.length);
      group_permissions temp_group = group_permissions(
          add_channel: group_perm_bool[0],
          add_modify_delete_roles: group_perm_bool[1],
          add_remove_members: group_perm_bool[2],
          add_edit_delete_events: group_perm_bool[3],
          delete_group: group_perm_bool[4]);
      role temp_role = role(
          role_name: temp_channel_name,
          group_permissions_for_role: temp_group,
          channel_permissions_for_role: list1);
      list_of_groups[g_index].all_roles.add(temp_role);
      print("printing channel roles length.......");
      print(list_of_groups[g_index]
          .all_roles[0]
          .channel_permissions_for_role
          .length);
      count++;
    }

    return ["true", decoded_retured_response['message']];
  } else {
    return ["false", decoded_retured_response['message']];
  }
}
