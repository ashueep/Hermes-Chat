


import 'package:chat_app_project/models/recv_class_for_messg.dart';

class DM{
  String DM_id;
  DM_users friend;
  List<updated_mssg_model> messages=[];
  DM({required this.DM_id,required this.friend,required this.messages});
}

class DM_users{
  String username;
  String u_id;
  String full_name;

  DM_users({required this.username,required this.u_id,required this.full_name});
}

class messages_for_DM{
  String sender_of_message_id;
  String time;
  String body_message;

  messages_for_DM({required this.sender_of_message_id, required this.time, required this.body_message});
}


List<DM> list_of_DMs=[];