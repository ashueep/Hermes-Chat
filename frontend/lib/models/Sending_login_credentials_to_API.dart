import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

Future<List<String>> sendData(String username, String password) async {
  List<String> response_to_be_returned = [];
  String temp_message = "";
  bool temp_login_status = true;
  String logstatus;
  Map Login_data = {'email': username, 'password': password, 'login': true};
  var body = JsonEncoder().convert(Login_data);
  print(body);
  var returned_login_result = await http.post(
      Uri.parse('http://192.168.116.1:3000/loginService'),
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
    temp_login_status = decoded_login_data['logstatus'];
    print(temp_login_status);


    temp_login_status == true ? logstatus = "true" : logstatus = "false";
    print(logstatus);

    response_to_be_returned.add(temp_message);
    response_to_be_returned.add(logstatus);

    return response_to_be_returned;
  }
}
