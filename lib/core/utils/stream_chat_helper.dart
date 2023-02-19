import 'package:jiffy/jiffy.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class StreamChatHelper {
  String getChannelName(Channel channel, User currentUser) {
    if (channel.name != null) {
      return channel.name!;
    } else if (channel.state?.members.isNotEmpty ?? false) {
      final otherMembers = channel.state?.members
          .where(
            (element) => element.userId != currentUser.id,
          )
          .toList();

      if (otherMembers?.length == 1) {
        return otherMembers!.first.user?.name ?? 'No name';
      } else {
        return 'Multiple users';
      }
    } else {
      return 'No Channel Name';
    }
  }

  String lastMessageTime(DateTime messageTime) {
    final lastMessageAt = messageTime.toLocal();
    String stringDate;
    final now = DateTime.now();

    final startOfDay = DateTime(now.year, now.month, now.day);

    if (lastMessageAt.millisecondsSinceEpoch >=
        startOfDay.millisecondsSinceEpoch) {
      stringDate = Jiffy(lastMessageAt.toLocal()).jm;
    } else if (lastMessageAt.millisecondsSinceEpoch >=
        startOfDay.subtract(const Duration(days: 1)).millisecondsSinceEpoch) {
      stringDate = 'YESTERDAY';
    } else if (startOfDay.difference(lastMessageAt).inDays < 7) {
      stringDate = Jiffy(lastMessageAt.toLocal()).EEEE;
    } else {
      stringDate = Jiffy(lastMessageAt.toLocal()).yMd;
    }
    return stringDate;
  }

  String getChatMessageTitle({required DateTime messageCreatedAt}) {
    late String dayInfo;
    final createdAt = Jiffy(messageCreatedAt);
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
    return dayInfo;
  }
}
