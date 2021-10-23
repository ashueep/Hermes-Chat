import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

Future<List<String>> send_create_account(String name, String password,String email) async {
  List<String> response_to_be_returned = [];
  String temp_message = "";
  bool temp_create_account_status = true;
  String create_account_status;
  Map Login_data = {'username': name, 'password': password, 'email': email};
  var body = JsonEncoder().convert(Login_data);
  print(body);
  var returned_create_account_result = await http.post(
      Uri.parse('http://192.168.116.1:3000/api/userService/createAccount'),
      headers: {"Content-Type": "application/json"},
      body: body);
  print(returned_create_account_result.statusCode);
  print(returned_create_account_result.headers);

  var decoded_create_account_data = jsonDecode(returned_create_account_result.body);
  print(decoded_create_account_data);

  if(returned_create_account_result.statusCode==500)
  {
    return ["Server Failure","false"];
  }
  else {
    temp_message = decoded_create_account_data['message'];
    temp_create_account_status = decoded_create_account_data['created']; //fix this after alan finishes
    print(temp_create_account_status);


    temp_create_account_status == true ? create_account_status = "true" : create_account_status = "false";
    print(create_account_status);

    response_to_be_returned.add(temp_message);
    response_to_be_returned.add(create_account_status);

    return response_to_be_returned;
  }
}
