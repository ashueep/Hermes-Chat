import 'dart:convert';
import 'package:chat_app_project/models/Groups_class_final.dart';
import 'package:chat_app_project/models/dm_model.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app_project/global_variables.dart';
import '../global_variables.dart';

Future<List<String>> fetch_channel_List(String token, String group_id,
    String channel_name, int g_index, int channel_index) async {
  list_of_DMs = [];
  Map jwt_token_var = {'token': token, 'chaName': channel_name};
  String dm_id;
  String username;
  String full_name;
  String id;
  String sender;
  String body_text;
  String timeStamp;
  list_of_groups[g_index]
      .channels_group_member_is_part_of[channel_index]
      .channel_mssgs = [];
  var body = JsonEncoder().convert(jwt_token_var);
  print(body);
  var returned_DM_List = await http.post(
      Uri.parse('$global_link/api/channels/$group_id/viewMessages'),
      headers: {"Content-Type": "application/json"},
      body: body);
  print(returned_DM_List.body);
  var decoded_return_channel_List = jsonDecode(returned_DM_List.body);
  print(decoded_return_channel_List);

  print(returned_DM_List.statusCode);
  if (returned_DM_List.statusCode == 500) {
    list_of_groups[g_index]
        .channels_group_member_is_part_of[channel_index]
        .channel_mssgs
        .length;
    return ["false", "Server Failure"];
  } else if (returned_DM_List.statusCode == 200 ||
      returned_DM_List.statusCode == 201) {
    print("inside status 200");
    can_write = decoded_return_channel_List['canWrite'];
    print("loggin canWrite value");
    print(can_write);
    print("nice");
    for (var one_val in decoded_return_channel_List['messages']) {
      sender = one_val['sender'];
      body_text = one_val['body'];
      timeStamp = one_val['timeStamp'];

      members_class temp_member = members_class(
          member_id: "",
          member_username: sender,
          member_full_name: "",
          member_roles: []);
      channel_messages temp_message = channel_messages(
          sent_by: temp_member, body_text: body_text, timestamp: timeStamp);
      print(temp_member.member_username);
      print("debugging");
      list_of_groups[g_index]
          .channels_group_member_is_part_of[channel_index]
          .channel_mssgs
          .insert(0, temp_message);
      print(list_of_groups[g_index]
          .channels_group_member_is_part_of[channel_index]
          .channel_mssgs
          .length);
    }
    print(list_of_groups[g_index]
        .channels_group_member_is_part_of[channel_index]
        .channel_mssgs
        .length);
    return ["true", "success", can_write.toString()];
  }
  return ["false", "unsuccessful"];
}
