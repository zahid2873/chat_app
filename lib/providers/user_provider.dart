import 'package:chat_app/db_helper/db_helper.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class UserProvider extends ChangeNotifier{
  Future<void> addUser(UserModel userModel) {
    return DbHelper.addUser(userModel);
  }


  }