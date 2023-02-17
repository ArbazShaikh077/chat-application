import 'package:chat_application/secreat.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class ChatClient {
  final client = StreamChatClient(streamKey);
  Future<void> connectUser() async {
    await client.connectUser(
        User(
          id: 'arbaz',
          image:
              'https://getstream.io/random_png/?id=cool-shadow-7&amp;name=Cool+shadow',
        ),
        client.devToken('arbaz').rawValue);
  }
}
