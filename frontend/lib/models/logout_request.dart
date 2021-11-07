import 'dart:convert';
import 'package:chat_app_project/models/dm_model.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app_project/global_variables.dart';

Future<List<String>> logout_request() async {
  List<String> response_to_be_returned = [];
  String temp_message_for_logout = "";
  bool new_logout_status = true;
  String logstatus_in_form_of_string = "";
  Map Logout_data = {'token': jwt_token};
  var body_logout = JsonEncoder().convert(Logout_data);
  print(body_logout);
  var returned_logout_result = await http.post(
      Uri.parse('$global_link/api/userService/logout'),
      headers: {"Content-Type": "application/json"},
      body: body_logout);

  if (returned_logout_result.statusCode == 500) {
    return ["Server Failure", "false"];
  } else {
    login_status = false;
    list_of_DMs = [];
    var decoded_logout_data = jsonDecode(returned_logout_result.body);
    print(decoded_logout_data);
    temp_message_for_logout = decoded_logout_data['message'];

    if (returned_logout_result.statusCode == 200) {
      new_logout_status = decoded_logout_data['logstatus'];
      login_status = false;
    } else {
      new_logout_status = false;
    }

    (new_logout_status == false)
        ? logstatus_in_form_of_string = "true"
        : logstatus_in_form_of_string = "false";
  }
  response_to_be_returned.add(temp_message_for_logout);
  response_to_be_returned.add(logstatus_in_form_of_string);

  return response_to_be_returned;
}
