import 'dart:convert';
import 'package:chat_app_project/models/Groups.dart';
import 'package:chat_app_project/models/Groups_class_final.dart';
import 'package:chat_app_project/models/dm_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app_project/global_variables.dart';
import '../global_variables.dart';

Future<List<String>> get_roles_associated_with_permissions(
    String channel_name, String perm_name, String g_id) async {
  String temp_mssg = "";
  bool success_var = false;
  String role_name = "";
  bool role_value = false;
  if (perm_name == "view permission") perm_name = "view";

  if (perm_name == "write permission") perm_name = "write";

  if (perm_name == "edit permission") perm_name = "edit";

  if (perm_name == "delete permission") perm_name = "delete";
  Map data_to_be_sent = {
    'token': jwt_token,
    'chaName': channel_name,
    'perm': perm_name
  };
  var body = JsonEncoder().convert(data_to_be_sent);
  print(body);
  var returned_create_new_role_response = await http.post(
      Uri.parse('$global_link/api/channels/$g_id/getChannelPermissions'),
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
    arr_for_chan_perms = [];
    var arr_of_roles = decoded_retured_response['permissions'];
    for (var arr_role_member in arr_of_roles) {
      role_name = arr_role_member['rolename'];
      role_value = arr_role_member['perm'];
      class_for_role_channel_perm temp_var = class_for_role_channel_perm(
          role_name: role_name, role_bool: role_value);
      arr_for_chan_perms.add(temp_var);
    }
    print(arr_for_chan_perms.length);
    return ["success", "true"];
  } else {
    return [decoded_retured_response['message'], "false"];
  }
}
