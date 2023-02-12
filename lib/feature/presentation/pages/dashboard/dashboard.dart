import 'dart:ui';

import 'package:chat_application/feature/presentation/pages/chat/chat.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Text(
          'Chat Application',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(itemBuilder: (_, index) {
        return Column(mainAxisSize: MainAxisSize.min, children: [
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => ChatScreen()));
            },
            tileColor: Colors.white10,
            leading: ClipOval(
              child: Image.asset(
                'assets/avaters/Avatar 4.jpg',
                height: 40,
              ),
            ),
            title: Text(
              'Chat - Name $index',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              "Long long message for the chat message $index ajsd akjsdh akdak djsakgd d askdh akdjh asdaj dhkajdhkja dskjahs ",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white),
            ),
            trailing: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Jan 23',
                  style: TextStyle(color: Colors.white30),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(122, 11, 192, 1.0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '123',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ]);
      }),
    );
  }
}
