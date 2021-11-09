import 'dart:convert';
import 'package:chat_app_project/models/dm_model.dart';
import 'package:chat_app_project/models/message_model.dart';
import 'package:chat_app_project/models/user_model.dart';
import 'package:http/http.dart' as http;
import '../global_variables.dart';

//make sure to complete this after finishing off building the proper Schema

Future<List<String>> CreateNewDM(String username) async {
  List<String> response_to_be_returned = [];
  String temp_message = " ";
  String user_id_to_create_DM = "";
  String full_name_of_created_DM = "";
  String DM_id;
  String logstatus_in_form_of_string = " ";
  Map Login_data = {'token': jwt_token, 'username': username};
  var body = JsonEncoder().convert(Login_data);
  print(body);
  var returned_login_result = await http.post(
      Uri.parse('$global_link/api/dms/create'),
      headers: {"Content-Type": "application/json"},
      body: body);
  print(returned_login_result.statusCode);
  print(returned_login_result.headers);

  print(jwt_token);

  var decoded_login_data = jsonDecode(returned_login_result.body);
  print(decoded_login_data);

  print(returned_login_result.statusCode);
  if (returned_login_result.statusCode == 500) {
    return ["Server Failure", "false"];
  } else if (returned_login_result.statusCode == 200 ||
      returned_login_result.statusCode == 201) {
    user_id_to_create_DM = decoded_login_data['user_id'];
    print(user_id_to_create_DM);
    full_name_of_created_DM = decoded_login_data['fullname'];
    print(full_name_of_created_DM);
    DM_id = decoded_login_data['dm_id'];
    print(DM_id);
    temp_message = decoded_login_data['message'];
    print(temp_message);

    response_to_be_returned.add(user_id_to_create_DM);
    response_to_be_returned.add(full_name_of_created_DM);
    response_to_be_returned.add(DM_id);
    response_to_be_returned.add(temp_message);

    print(temp_message);
    if (temp_message == "DM created") {
      print("inside DM created");
      print(list_of_DMs.length);
      DM_users temp_friend = DM_users(
          username: username,
          u_id: user_id_to_create_DM,
          full_name: full_name_of_created_DM);
      DM temp_DM = DM(DM_id: DM_id, friend: temp_friend, messages: []);
      list_of_DMs.add(temp_DM);
      print(list_of_DMs.length);
    }

    return response_to_be_returned;
  }
  response_to_be_returned.add("");
  response_to_be_returned.add("");
  response_to_be_returned.add("");
  response_to_be_returned.add(decoded_login_data['message']);
  return response_to_be_returned;
}
