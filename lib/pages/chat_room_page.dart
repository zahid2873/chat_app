import 'package:chat_app/widget/message_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/chat_room_provider.dart';
import '../widget/main_drawer.dart';

class ChatRoomPage extends StatefulWidget {
  static const String routeName = '/chat_room';
  const ChatRoomPage({Key? key}) : super(key: key);

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  bool isFirst=true;
  @override
  void didChangeDependencies() {
    if(isFirst){
      Provider.of<ChatRoomProvider>(context,listen: false).getChatRoomMessages();
    }
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: const Text("Chat Room"),
      ),
      body: Consumer<ChatRoomProvider>(
        builder: (context,provider,_)=>Column(
          children: [
            Expanded(child: ListView.builder(
                itemCount: provider.msgList.length,
                itemBuilder: (context,index){
                  final messageModel = provider.msgList[index];
                  return MessageItem(messageModel: messageModel);
                  },
                ),
            ),
            Row(),
          ],
        ),
      ),
    );
  }
}
