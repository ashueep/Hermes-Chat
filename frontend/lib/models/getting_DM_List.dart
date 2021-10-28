import 'dart:convert';
import 'package:chat_app_project/models/dm_model.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app_project/global_variables.dart';
import '../global_variables.dart';

Future<List<String>> fetch_DM_List(String token) async{
  Map jwt_token_var = {'token': token};
  String dm_id;
  String username;
  String full_name;
  String id;

  var body = JsonEncoder().convert(jwt_token_var);
  print(body);
  var returned_DM_List = await http.post(
      Uri.parse('http://192.168.116.1:3000/api/dms/viewDM'),
      headers: {"Content-Type": "application/json"},
      body: body);
      print(returned_DM_List.body);
  var decoded_return_DM_List = jsonDecode(returned_DM_List.body);
  print(decoded_return_DM_List);

  print(returned_DM_List.statusCode);
  if(returned_DM_List.statusCode==500)
  {
    return ["false","Server Failure"];
  }
  else if(returned_DM_List.statusCode==200 || returned_DM_List.statusCode==201){
      for(var one_val in decoded_return_DM_List)
        {
          dm_id=one_val['dmid'];
          var temp1=one_val['friend'];
          username=temp1['username'];
          full_name=temp1['fullname'];
          id=temp1['id'];

          DM_users temp_friend=DM_users(username: username,u_id: id,full_name: full_name);
          print(temp_friend.full_name);
          DM tempDM=DM(DM_id: dm_id,friend: temp_friend,messages: []);
          list_of_DMs.add(tempDM);

        }
      return ["true","success"];
  }
  return ["false","unsuccessful"];
}