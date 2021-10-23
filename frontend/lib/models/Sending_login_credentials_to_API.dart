import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import '../global_variables.dart';

Future<List<String>> sendData(String username, String password) async {
  List<String> response_to_be_returned = [];
  String temp_message = " ";
  bool new_login_status=false;
  String logstatus_in_form_of_string=" ";
  Map Login_data = {'email': username, 'password': password};
  var body = JsonEncoder().convert(Login_data);
  print(body);
  var returned_login_result = await http.post(
      Uri.parse('http://192.168.116.1:3000/api/userService/login'),
      headers: {"Content-Type": "application/json"},
      body: body);
  print(returned_login_result.statusCode);
  print(returned_login_result.headers);

  var decoded_login_data = jsonDecode(returned_login_result.body);
  print(decoded_login_data);

  if(returned_login_result.statusCode==500)
    {
      return ["Server Failure","false"];
    }
  else {
    temp_message = decoded_login_data['message'];
    new_login_status = decoded_login_data['logstatus'];
    (new_login_status == true) ? logstatus_in_form_of_string = "true" : logstatus_in_form_of_string = "false";
    print(logstatus_in_form_of_string);
    if(new_login_status==true && login_status==false)
      {
        jwt_token = decoded_login_data['token'];
      }
    login_status=new_login_status;
    print(jwt_token);
    print(new_login_status);
    print("current global logstatus is: ");
    print(login_status);
    print(logstatus_in_form_of_string);



    response_to_be_returned.add(temp_message);
    response_to_be_returned.add(logstatus_in_form_of_string);

    return response_to_be_returned;
  }
}
