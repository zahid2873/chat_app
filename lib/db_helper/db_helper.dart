import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/user_model.dart';

class DbHelper{
  static const String _collectionUser = 'Users';
  static const String _collectionChatRoomMessages = 'ChatRoomMessages';
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> addUser(UserModel userModel) {
    final doc = _db.collection(_collectionUser).doc(userModel.uid);
    return doc.set(userModel.toMap());
  }

  static Future<void> addMsg(MessageModel messageModel)=>
  _db.collection(_collectionChatRoomMessages).doc().set(messageModel.toMap());

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllChatRoomMessages()=>
  _db.collection(_collectionChatRoomMessages).snapshots();

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUserById(String uid) =>
      _db.collection(_collectionUser).doc(uid).snapshots();

  static Future<void> updateProfile(String uid, Map<String, dynamic>map){
    return _db.collection(_collectionUser).doc(uid).update(map);
  }


}