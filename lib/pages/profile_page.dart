import 'package:chat_app/auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/profile';

  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(onPressed: (){
            AuthService.logOut();
            Navigator.pushNamed(context, LoginPage.routeName);
          }, icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}
