
bool login_status=false;
String jwt_token="";
String username_of_current_user="";
var u_id;
bool can_write=false;
List<class_for_role_channel_perm> arr_for_chan_perms=[];
String global_link = 'https://hermes-deploy-project.herokuapp.com';

class class_for_role_channel_perm{
  String role_name="";
  bool role_bool=false;
  class_for_role_channel_perm({required this.role_name,required this.role_bool});
}