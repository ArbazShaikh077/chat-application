import 'dart:async';

import 'package:chat_application/core/utils/stream_chat_helper.dart';
import 'package:chat_application/feature/presentation/pages/chat/widgets/bottom_message_send_bar.dart';
import 'package:chat_application/feature/presentation/pages/chat/widgets/message_own_tile.dart';
import 'package:chat_application/feature/presentation/pages/chat/widgets/message_tile.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.channel});
  final Channel channel;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late StreamSubscription<int> unreadCountSubscription;

  @override
  void initState() {
    unreadCountSubscription = StreamChannel.of(context)
        .channel
        .state!
        .unreadCountStream
        .listen(_unreadCountHandler);
    super.initState();
  }

  Future<void> _unreadCountHandler(int count) async {
    if (count > 0) {
      await StreamChannel.of(context).channel.markRead();
    }
  }

  @override
  void dispose() {
    unreadCountSubscription.cancel();
    super.dispose();
  }

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
              children: const [
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
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert_sharp))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: MessageListCore(
              loadingBuilder: (context) {
                return const Center(child: CircularProgressIndicator());
              },
              emptyBuilder: (context) => const SizedBox.shrink(),
              errorBuilder: (context, error) => const Center(
                  child: Text(
                "error",
                style: TextStyle(color: Colors.white),
              )),
              messageListBuilder: (_, messages) => ListView.builder(
                reverse: true,
                padding:
                    const EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                itemBuilder: (_, index) {
                  final messageTitle = StreamChatHelper().getChatMessageTitle(
                      messageCreatedAt: messages[index].createdAt);
                  return Column(
                    children: [
                      if (index == messages.length - 1 ||
                          messages[index].createdAt.day !=
                              messages[index + 1].createdAt.day)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(
                            messageTitle,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                        ),
                      messages[index].user?.id ==
                              StreamChatCore.of(context).currentUser!.id
                          ? MessageOwnTile(
                              message: messages[index].text ?? "",
                              messageDate: messages[index].createdAt)
                          : MessageTile(
                              message: messages[index].text ?? "",
                              messageDate: messages[index].createdAt)
                    ],
                  );
                },
                itemCount: messages.length,
              ),
            ),
          ),
          BottomMessageSendBar(
            channel: widget.channel,
          )
        ],
      ),
    );
  }
}
