import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class ChatClient {
  Future<void> connectUser() async {
    final client = StreamChatClient('client-token');
    await client.connectUser(
      User(
        id: 'cool-shadow-7',
        image:
            'https://getstream.io/random_png/?id=cool-shadow-7&amp;name=Cool+shadow',
      ),
      '''eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiY29vbC1zaGFkb3ctNyJ9.gkOlCRb1qgy4joHPaxFwPOdXcGvSPvp6QY0S4mpRkVo''',
    );
  }
}
