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
  bool isFirst = true;
  final txtController = TextEditingController();

  @override
  void dispose() {
    txtController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (isFirst) {
      Provider.of<ChatRoomProvider>(context, listen: false)
          .getChatRoomMessages();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: const Text("Chat Room"),
      ),
      body: Consumer<ChatRoomProvider>(
        builder: (context, provider, _) => Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: provider.msgList.length,
                itemBuilder: (context, index) {
                  final messageModel = provider.msgList[index];
                  return MessageItem(messageModel: messageModel);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: txtController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          fillColor: Colors.white,
                          hintText: "Type your message"),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (txtController.text.isEmpty) return;
                        provider.addMessage(txtController.text);
                        txtController.clear();
                      },
                      icon: Icon(
                        Icons.send,
                        color: Theme.of(context).primaryColor,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
