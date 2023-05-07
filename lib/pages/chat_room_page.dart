import 'package:flutter/material.dart';

import '../widget/main_drawer.dart';

class ChatRoomPage extends StatefulWidget {
  static const String routeName = '/chat_room';
  const ChatRoomPage({Key? key}) : super(key: key);

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: const Text("Chat Room"),
      ),
    );
  }
}
