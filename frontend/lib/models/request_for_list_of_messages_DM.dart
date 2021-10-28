import 'dart:convert';
import 'package:chat_app_project/models/dm_model.dart';
import 'package:chat_app_project/widgets/List_of_roles.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app_project/global_variables.dart';
import 'package:chat_app_project/models/recv_class_for_messg.dart';

request_for_list_of_messages_for_DM(int k) async
{
  Map jwt_token_var = {'token': jwt_token};
  String dm_id=list_of_DMs[k].DM_id;
  updated_mssg_model temp_message=updated_mssg_model(sender_username: "", text_message: "", time_stamp: "");

  var body = JsonEncoder().convert(jwt_token_var);
  var returned_list_of_DM_messages = await http.post(
      Uri.parse('http://192.168.116.1:3000/api/dms/$dm_id/view'),
      headers: {"Content-Type": "application/json"},
      body: body);

  print(returned_list_of_DM_messages);
  var decoded_return_list_of_DMs = jsonDecode(returned_list_of_DM_messages.body);
  print(decoded_return_list_of_DMs);
  List<updated_mssg_model> temp_update=[updated_mssg_model(sender_username: "", text_message: "", time_stamp: "")];
  if(returned_list_of_DM_messages.statusCode==201 || returned_list_of_DM_messages.statusCode==200)
    {
      List<dynamic> temp_messages_list = decoded_return_list_of_DMs;
      int size=temp_messages_list.length;
      print("jajajajjajajajjajajjajajajjajaa");
      print(username_of_current_user);
      for(int i=0;i<size;i++)
        {
          updated_mssg_model temp_message1=updated_mssg_model(sender_username: "", text_message: "", time_stamp: "");
          temp_message.sender_username=temp_messages_list[i]['sender'];
          print(temp_message.sender_username);

          temp_message1.sender_username=temp_message.sender_username;
          print(temp_message1.sender_username);

          temp_message.time_stamp=temp_messages_list[i]['timeStamp'];
          print(temp_message.time_stamp);

          temp_message1.time_stamp=temp_message.time_stamp;

          temp_message.text_message=temp_messages_list[i]['body'];
          print(temp_message.text_message);

          temp_message1.text_message=temp_message.text_message;
          print(list_of_DMs[k].friend.full_name);

          temp_update.add(temp_message1);

        }
      temp_update.removeAt(0);
      List<updated_mssg_model> reversed_list = new List.from(temp_update.reversed);

      print(temp_update[0].text_message);
      print(temp_update[1].text_message);
      list_of_DMs[k].messages=reversed_list;
      print("");
      print("");
      for(int j=0;j<list_of_DMs[k].messages.length;j++)
      {
        print(list_of_DMs[k].messages[j].text_message);
        print("next message");
      }

    }
  else
    {
      ;
    }

}