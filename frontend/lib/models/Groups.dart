import 'package:chat_app_project/models/user_model.dart';

import 'channels.dart';

class Groups {
  final int G_id;
  final String Group_name;
  final List<USER> Members;
  final List<CHANNELS> group_channels;

  Groups({
    required this.G_id,
    required this.Group_name,
    required this.Members,
    required this.group_channels,
  });
}

final USER currentUser = USER(
  id: 0,
  name: 'Current User',
  imageUrl: 'assets/images/greg.jpg.png',
);

// USERS
final USER aashish = USER(
  id: 1,
  name: 'Aashish',
  imageUrl: 'assets/images/me.jpg.png',
);
final USER alan = USER(
  id: 2,
  name: 'Alan Tony',
  imageUrl: 'assets/images/james.jpg.png',
);
final USER john = USER(
  id: 3,
  name: 'John',
  imageUrl: 'assets/images/john.jpg.png',
);
final USER dolly = USER(
  id: 4,
  name: 'Dolly',
  imageUrl: 'assets/images/olivia.jpg.png',
);

final USER sudarshan = USER(
  id: 5,
  name: 'Sudarshan',
  imageUrl: 'assets/images/sam.jpg.png',
);
final USER ashutosh = USER(
  id: 6,
  name: 'Ashutosh',
  imageUrl: 'assets/images/sophia.jpg.png',
);
final USER rishikesh = USER(
  id: 7,
  name: 'Rishikesh',
  imageUrl: 'assets/images/steven.jpg.png',
);

List<Groups> groups = [
  Groups(
    G_id: 1,
    Group_name: "SE Lab Project",
    Members: [sudarshan, aashish, ashutosh, alan],
    group_channels: [channels[0],channels[1],channels[2]],
  ),
  Groups(
    G_id: 2,
    Group_name: "Goldman Sachs",
    Members: [sudarshan, john, ashutosh],
    group_channels: [channels[2]]
  ),
  Groups(
    G_id: 3,
    Group_name: "Oracle",
    Members: [aashish, dolly, alan],
    group_channels: [channels[0],channels[1]],
  ),
  Groups(
    G_id: 4,
    Group_name: "MATHWORKS",
    Members: [rishikesh, aashish, dolly],
    group_channels: [channels[2],channels[0]],
  ),
  Groups(
    G_id: 5,
    Group_name: "SE THEORY PROJECT",
    Members: [rishikesh, aashish, dolly, ashutosh],
    group_channels: [channels[1]],
  ),
];
