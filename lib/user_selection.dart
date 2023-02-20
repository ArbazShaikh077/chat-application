import 'package:chat_application/feature/presentation/pages/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class UserSelection extends StatelessWidget {
  const UserSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User selection'),
      ),
      body: ListView.builder(
          itemCount: userList.length,
          itemBuilder: (_, index) => ListTile(
                title: Text(userList[index].name ?? "Name"),
                onTap: () async {
                  NavigatorState nav = Navigator.of(context);
                  StreamChatCoreState stream = StreamChatCore.of(context);
                  await StreamChatCore.of(context).client.connectUser(
                      User(
                          id: userList[index].userId ?? "id",
                          name: userList[index].name),
                      StreamChatCore.of(context)
                          .client
                          .devToken(userList[index].userId ?? 'userId')
                          .rawValue);
                  Channel state =
                      stream.client.channel('messaging', extraData: {
                    'members': [
                      userList[index].userId,
                      userList[index].userId == 'arbaz' ? 'aamir' : 'arbaz'
                    ]
                  });
                  await state.watch();

                  nav.push(
                      MaterialPageRoute(builder: (_) => const Dashboard()));
                },
              )),
    );
  }
}

class CustomUser {
  final String? name;
  final String? userId;
  final String? imageUrl;

  CustomUser({this.name, this.userId, this.imageUrl});
}

final List<CustomUser> userList = [
  CustomUser(name: "Arbaz", userId: "arbaz"),
  CustomUser(name: "Aamir", userId: "aamir"),
];
