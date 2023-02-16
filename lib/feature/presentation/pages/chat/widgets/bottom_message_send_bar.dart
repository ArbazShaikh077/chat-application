import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomMessageSendBar extends StatefulWidget {
  const BottomMessageSendBar({Key? key}) : super(key: key);

  @override
  State<BottomMessageSendBar> createState() => __ActionBarState();
}

class __ActionBarState extends State<BottomMessageSendBar> {
  final TextEditingController controller = TextEditingController();

  Future<void> _sendMessage() async {}

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white10,
      child: SafeArea(
        bottom: true,
        top: false,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(CupertinoIcons.camera_fill),
              color: Colors.white,
              onPressed: () {},
            ),
            Expanded(
              child: TextField(
                controller: controller,
                style: const TextStyle(fontSize: 14, color: Colors.white),
                maxLines: 5,
                minLines: 1,
                decoration: const InputDecoration(
                  hintText: 'Message',
                  hintStyle: TextStyle(color: Colors.white54, fontSize: 14),
                  border: InputBorder.none,
                  fillColor: Colors.transparent,
                  isCollapsed: true,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  filled: true,
                  isDense: true,
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
            IconButton(
              color: Colors.white,
              icon: const Icon(Icons.send_rounded),
              onPressed: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
