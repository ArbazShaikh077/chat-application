import 'package:chat_application/feature/presentation/pages/chat/widgets/message_own_tile.dart';
import 'package:chat_application/feature/presentation/pages/chat/widgets/message_tile.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.white10,
        title: Row(
          children: [
            CircleAvatar(),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name goes here...",
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  'Status goes here..',
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_sharp))
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 5, left: 5, right: 5),
        itemBuilder: (_, index) => Column(
          children: [
            if (index == 0 ||
                messageThread[index].time.day !=
                    messageThread[index - 1].time.day)
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  messageThread[index].time.toIso8601String(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            messageThread[index].isMyMessage
                ? MessageOwnTile(
                    message: messageThread[index].message ?? "",
                    messageDate: messageThread[index].time.toIso8601String())
                : MessageTile(
                    message: messageThread[index].message ?? "",
                    messageDate: messageThread[index].time.toIso8601String())
          ],
        ),
        itemCount: messageThread.length,
      ),
    );
  }
}

List<Message> messageThread = [
  Message(isMyMessage: true, message: "hello", time: DateTime.now()),
  Message(isMyMessage: false, message: "hello", time: DateTime.now()),
  Message(isMyMessage: true, message: "hello", time: DateTime.now()),
  Message(isMyMessage: false, message: "hello", time: DateTime.now()),
  Message(isMyMessage: true, message: "hello", time: DateTime.now()),
  Message(isMyMessage: false, message: "hello", time: DateTime.now()),
  Message(isMyMessage: true, message: "hello", time: DateTime.now()),
];

class Message {
  Message({this.message, required this.isMyMessage, required this.time});

  final bool isMyMessage;
  final String? message;
  final DateTime time;
}
