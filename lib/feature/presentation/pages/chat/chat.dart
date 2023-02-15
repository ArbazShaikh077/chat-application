import 'package:chat_application/feature/presentation/pages/chat/widgets/bottom_message_send_bar.dart';
import 'package:chat_application/feature/presentation/pages/chat/widgets/message_own_tile.dart';
import 'package:chat_application/feature/presentation/pages/chat/widgets/message_tile.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

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
            const CircleAvatar(),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name goes here...",
                  style: TextStyle(fontSize: 15),
                ),
                const Text(
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
              itemBuilder: (_, index) {
                late String dayInfo;
                final createdAt = Jiffy(DateTime.now());
                final now = DateTime.now();
                if (Jiffy(createdAt).isSame(now, Units.DAY)) {
                  dayInfo = 'TODAY';
                } else if (Jiffy(createdAt)
                    .isSame(now.subtract(const Duration(days: 1)), Units.DAY)) {
                  dayInfo = 'YESTERDAY';
                } else if (Jiffy(createdAt).isAfter(
                  now.subtract(const Duration(days: 7)),
                  Units.DAY,
                )) {
                  dayInfo = createdAt.EEEE;
                } else if (Jiffy(createdAt).isAfter(
                  Jiffy(now).subtract(years: 1),
                  Units.DAY,
                )) {
                  dayInfo = createdAt.MMMd;
                } else {
                  dayInfo = createdAt.MMMd;
                }
                return Column(
                  children: [
                    if (index == messageThread.length - 1 ||
                        messageThread[index].time.day !=
                            messageThread[index + 1].time.day)
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          dayInfo,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    messageThread[index].isMyMessage
                        ? MessageOwnTile(
                            message: messageThread[index].message ?? "",
                            messageDate: messageThread[index].time)
                        : MessageTile(
                            message: messageThread[index].message ?? "",
                            messageDate: messageThread[index].time)
                  ],
                );
              },
              itemCount: messageThread.length,
            ),
          ),
          const BottomMessageSendBar()
        ],
      ),
    );
  }
}

List<Message> messageThread = [
  Message(
      isMyMessage: true,
      message:
          "hello agjd asjd gadgaashgdd asdga jdgakjgdkagd adajgdkjagdkja dagd jagdkjg as",
      time: DateTime.now()),
  Message(
      isMyMessage: false,
      message: "hello  aksjgda dkjagd kasgdkads asdjgak sdasd agda ",
      time: DateTime.now()),
  Message(
      isMyMessage: true,
      message:
          "hellasdh kad akjdg kajdga jdg  askjdhakj daksdhjka sdagdas dsjsdkaso",
      time: DateTime.now()),
  Message(
      isMyMessage: false,
      message:
          "helas dkasjhdkja dakjsdhjkas dakdhkjashdka dasjd gaudt iahdlkahfu tuiafnsagfuisafhaskjfgk s lo",
      time: DateTime.now()),
  Message(isMyMessage: true, message: "hello", time: DateTime.now()),
  Message(isMyMessage: false, message: "hello", time: DateTime.now()),
  Message(
      isMyMessage: true,
      message:
          "hellasdh kad akjdg kajdga jdg  askjdhakj daksdhjka sdagdas dsjsdkaso",
      time: DateTime.now()),
  Message(
      isMyMessage: false,
      message:
          "helas dkasjhdkja dakjsdhjkas dakdhkjashdka dasjd gaudt iahdlkahfu tuiafnsagfuisafhaskjfgk s lo",
      time: DateTime.now()),
  Message(
      isMyMessage: true,
      message:
          "hellasdh kad akjdg kajdga jdg  askjdhakj daksdhjka sdagdas dsjsdkaso",
      time: DateTime.now()),
  Message(
      isMyMessage: false,
      message:
          "helas dkasjhdkja dakjsdhjkas dakdhkjashdka dasjd gaudt iahdlkahfu tuiafnsagfuisafhaskjfgk s lo",
      time: DateTime.now()),
  Message(
      isMyMessage: true,
      message:
          "hellasdh kad akjdg kajdga jdg  askjdhakj daksdhjka sdagdas dsjsdkaso",
      time: DateTime.now()),
  Message(
      isMyMessage: false,
      message:
          "helas dkasjhdkja dakjsdhjkas dakdhkjashdka dasjd gaudt iahdlkahfu tuiafnsagfuisafhaskjfgk s lo",
      time: DateTime.now()),
  Message(
      isMyMessage: true,
      message:
          "hellasdh kad akjdg kajdga jdg  askjdhakj daksdhjka sdagdas dsjsdkaso",
      time: DateTime.now()),
  Message(
      isMyMessage: false,
      message:
          "helas dkasjhdkja dakjsdhjkas dakdhkjashdka dasjd gaudt iahdlkahfu tuiafnsagfuisafhaskjfgk s lo",
      time: DateTime.now()),
  Message(
      isMyMessage: true,
      message: "helajshdkjas dasdhiuad ashjdtaidgkjslo",
      time: DateTime.now()),
];

class Message {
  Message({this.message, required this.isMyMessage, required this.time});

  final bool isMyMessage;
  final String? message;
  final DateTime time;
}
