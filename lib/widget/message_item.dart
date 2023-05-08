import 'package:chat_app/auth/firebase_auth.dart';
import 'package:chat_app/utils/helper_function.dart';
import 'package:flutter/material.dart';

import '../models/message_model.dart';

class MessageItem extends StatelessWidget {
  final MessageModel messageModel;
  const MessageItem({Key? key,required this.messageModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: messageModel.userUid == AuthService.user!.uid ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(messageModel.userName ?? messageModel.email, style: TextStyle(color: Colors.blue,fontSize: 12),),
            Text(getFormattedDate(messageModel.timestamp.toDate(), "dd/MM/yyyy HH:mm"), style: TextStyle(color: Colors.grey,fontSize: 12),),
            Text(messageModel.msg, style: TextStyle(color: Colors.black,fontSize: 14),),

          ],
        ),
      ),
    );
  }
}
