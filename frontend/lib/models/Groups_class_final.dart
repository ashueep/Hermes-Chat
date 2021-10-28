
import 'package:chat_app_project/models/Groups.dart';
import 'package:chat_app_project/models/dm_model.dart';
import 'package:chat_app_project/models/recv_class_for_messg.dart';

class groups_class{
  String group_id;
  role user_role;
  List<members_class> members;
  List<channels> channels_group_member_is_part_of;
  List<events> events_that_group_member_is_part_of;
  groups_class({required this.group_id, required this.user_role,required this.members, required this.channels_group_member_is_part_of,
  required this.events_that_group_member_is_part_of
  });
}

class members_class{
  String member_id;
  String member_username;
  String member_full_name;
  List<String> member_roles;

  members_class({required this.member_id,required this.member_username,
    required this.member_full_name, required this.member_roles,
  });

}

class role{
  String role_id;
  String role_name;
  List<group_permissions> group_permissions_for_role;
  List<channels_permissions> channel_permissions_for_role;
  role({required this.role_id,required this.role_name, required this.group_permissions_for_role,required this.channel_permissions_for_role});
}

class group_permissions{
  bool add_channel=false;
  bool add_modify_delete_roles=false;
  bool add_remove_members=false;
  bool add_edit_delete_events=false;
  bool delete_group=false;

  group_permissions({required this.add_channel,required this.add_modify_delete_roles,
    required this.add_remove_members, required this.add_edit_delete_events,
    required this.delete_group});
}

class channels_permissions{
  bool view_perm=false;
  bool write_perm=false;
  bool edit_perm=false;
  bool delete_channel_perm=false;

  channels_permissions({required this.view_perm,required this.write_perm,required this.edit_perm,required this.delete_channel_perm});

}

class channels{
  String channel_id;
  String channel_name;
  List<channel_messages> channel_mssgs;

  channels({required this.channel_id, required this.channel_name,required this.channel_mssgs});
}

class channel_messages{
  members_class sent_by;
  String body_text;
  String timestamp;

  channel_messages({required this.sent_by, required this.body_text, required this.timestamp});
}

class events{
  String event_id;
  String event_name;
  String event_date;
  List<String>? roles;
  events({required this.event_id, required this.event_name, required this.event_date, required this.roles});
}


List<groups_class> groups=[];




