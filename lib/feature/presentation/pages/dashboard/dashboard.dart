import 'package:chat_application/core/utils/stream_chat_helper.dart';
import 'package:chat_application/feature/presentation/pages/chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late final channelListController = StreamChannelListController(
    client: StreamChatCore.of(context).client,
    filter: Filter.and([
      Filter.equal('type', 'messaging'),
      Filter.in_(
        'members',
        [
          StreamChatCore.of(context).currentUser!.id,
        ],
      ),
    ]),
  );

  @override
  void initState() {
    channelListController.doInitialLoad();
    super.initState();
  }

  @override
  void dispose() {
    channelListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Text(
          'Chat Application',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: PagedValueListenableBuilder<int, Channel>(
        valueListenable: channelListController,
        builder: (context, value, child) {
          return value.when(
            (channels, nextPageKey, error) => LazyLoadScrollView(
              onEndOfPage: () async {
                if (nextPageKey != null) {
                  channelListController.loadMore(nextPageKey);
                }
              },
              child: channels.isEmpty
                  ? const Center(
                      child: Text(
                        "Chat not found",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : ListView.builder(
                      itemCount: channels.length,
                      itemBuilder: (_, index) {
                        return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => StreamChannel(
                                            channel: channels[index],
                                            child: ChatScreen(
                                              channel: channels[index],
                                            ),
                                          )));
                                },
                                tileColor: Colors.white10,
                                leading: ClipOval(
                                  child: Image.asset(
                                    'assets/avaters/Avatar 4.jpg',
                                    height: 40,
                                  ),
                                ),
                                title: Text(
                                  StreamChatHelper().getChannelName(
                                      channels[index],
                                      StreamChatCore.of(context).currentUser!),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                subtitle: BetterStreamBuilder<int>(
                                    stream: channels[index]
                                        .state!
                                        .unreadCountStream,
                                    initialData:
                                        channels[index].state?.unreadCount ?? 0,
                                    builder: (context, count) {
                                      return BetterStreamBuilder<Message>(
                                          stream: channels[index]
                                              .state!
                                              .lastMessageStream,
                                          initialData: channels[index]
                                              .state!
                                              .lastMessage,
                                          builder: (_, snapshot) {
                                            return Text(
                                              snapshot.text ?? "",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            );
                                          });
                                    }),
                                trailing: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    BetterStreamBuilder<DateTime>(
                                        stream:
                                            channels[index].lastMessageAtStream,
                                        initialData:
                                            channels[index].lastMessageAt,
                                        builder: (_, data) {
                                          final String messageTime =
                                              StreamChatHelper()
                                                  .lastMessageTime(
                                                      data.toLocal());
                                          return Text(
                                            messageTime,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.white30),
                                          );
                                        }),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    BetterStreamBuilder<int>(
                                        stream: channels[index]
                                            .state!
                                            .unreadCountStream,
                                        initialData: channels[index]
                                                .state
                                                ?.unreadCount ??
                                            0,
                                        builder: (_, snapshot) {
                                          if (snapshot == 0) {
                                            return const SizedBox.shrink();
                                          }
                                          return Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  122, 11, 192, 1.0),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              snapshot.toString(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          );
                                        }),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ]);
                      }),
            ),
            loading: () => const Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(),
              ),
            ),
            error: (e) => Center(
              child: Text(
                'Oh no, something went wrong. '
                'Please check your config. $e',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
