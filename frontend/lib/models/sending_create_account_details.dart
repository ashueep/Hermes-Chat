import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import '../global_variables.dart';

Future<List<String>> send_create_account(
    String name, String password, String email, String UserName) async {
  List<String> response_to_be_returned = [];
  String temp_message = "";
  String temp_level1 = "";
  bool temp_create_account_status = true;
  String create_account_status;
  Map Login_data = {
    'username': UserName,
    'fullname': name,
    'password': password,
    'email': email,
  };
  var body = JsonEncoder().convert(Login_data);
  print(body);
  var returned_create_account_result = await http.post(
      Uri.parse('$global_link/api/userService/createAccount'),
      headers: {"Content-Type": "application/json"},
      body: body);
  print(returned_create_account_result.statusCode);
  print(returned_create_account_result.headers);

  var decoded_create_account_data =
      jsonDecode(returned_create_account_result.body);
  print(decoded_create_account_data);
  print(returned_create_account_result.statusCode);
  if (returned_create_account_result.statusCode == 500) {
    return ["Server Failure", "false"];
  } else if (returned_create_account_result.statusCode == 200 ||
      returned_create_account_result.statusCode == 201) {
    temp_message = decoded_create_account_data['message'];
    temp_create_account_status =
        decoded_create_account_data['created']; //fix this after alan finishes
    print(temp_create_account_status);
    print(temp_message);
    var temp_nested_messg_for_newuser = decoded_create_account_data['newUser'];
    u_id = temp_nested_messg_for_newuser['_id'];
    print(u_id);
    temp_create_account_status == true
        ? create_account_status = "true"
        : create_account_status = "false";
    print(create_account_status);

    response_to_be_returned.add(temp_message);
    response_to_be_returned.add(create_account_status);

    return response_to_be_returned;
  } else {
    temp_message = decoded_create_account_data['message'];
    create_account_status = "false";

    response_to_be_returned.add(temp_message);
    response_to_be_returned.add((create_account_status));
    return response_to_be_returned;
  }
}
