import 'package:chat_app_project/models/Groups.dart';
import 'package:chat_app_project/models/user_model.dart';

class CHANNELS {
  final String name;
  final List<USER> members;

  CHANNELS({required this.name, required this.members});
}

List<CHANNELS> channels = [
  CHANNELS(name: "frontend", members: [aashish,alan]),
  CHANNELS(name: "backend", members: [ashutosh,sudarshan]),
  CHANNELS(name: "testing", members: [ashutosh,sudarshan,alan,aashish]),


];