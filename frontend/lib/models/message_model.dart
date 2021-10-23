import 'package:chat_app_project/models/user_model.dart';

class Message {
  final USER sender;
  final String time;
  final String text;
  final bool isLiked; //remove this
  final bool unread;

  Message({
    required this.sender,
    required this.time,
    required this.text,
    required this.isLiked,
    required this.unread,
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

List<USER> recents = [dolly, alan, john, ashutosh, rishikesh];

List<Message> chats = [
  Message(
    sender: alan,
    time: '5:30 PM',
    text: 'Nah Its chill brooo',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: dolly,
    time: '4:30 PM',
    text: 'Finished CN lab work?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: john,
    time: '3:30 PM',
    text: 'damnn it was a lit partyyy!!!',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: ashutosh,
    time: '2:30 PM',
    text: 'peace out!',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: rishikesh,
    time: '1:30 PM',
    text: 'im going to paris next week',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: sudarshan,
    time: '12:30 PM',
    text: 'thats alright!',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: aashish,
    time: '11:30 AM',
    text: 'xD',
    isLiked: false,
    unread: false,
  ),
];

// EXAMPLE MESSAGES IN CHAT SCREEN
List<Message> messages = [
  Message(
    sender: alan,
    time: '5:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: true,
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '4:30 PM',
    text: 'Just walked my doge. She was super duper cute. The best pupper!!',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: alan,
    time: '3:45 PM',
    text: 'How\'s the doggo?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: alan,
    time: '3:15 PM',
    text: 'All the food',
    isLiked: true,
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '2:30 PM',
    text: 'Nice! What kind of food did you eat?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: alan,
    time: '2:00 PM',
    text: 'I ate so much food today.',
    isLiked: false,
    unread: true,
  ),
];
