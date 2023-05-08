import 'package:chat_app/auth/firebase_auth.dart';
import 'package:chat_app/db_helper/db_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/message_model.dart';

class ChatRoomProvider extends ChangeNotifier {
  List<MessageModel> msgList = [];

  Future<void> addMessage(String msg) {
    final messageModel = MessageModel(
        msgId: DateTime.now().millisecondsSinceEpoch,
        userUid: AuthService.user!.uid,
        userName: AuthService.user!.displayName,
        userImage: AuthService.user!.photoURL,
        email: AuthService.user!.email!,
        msg: msg,
        timestamp: Timestamp.now());
    return DbHelper.addMsg(messageModel);
  }

  getChatRoomMessages(){
    DbHelper.getAllChatRoomMessages().listen((snapshot) {
      msgList = List.generate(snapshot.docs.length, (index) =>
          MessageModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });

  }
}
