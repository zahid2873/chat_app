import 'package:chat_app/auth/firebase_auth.dart';
import 'package:chat_app/pages/chat_room_page.dart';
import 'package:chat_app/pages/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../pages/launcher_page.dart';
import '../providers/user_provider.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
// Container(
//   height: 200,
//   color: Colors.blue,
// ),
          Consumer<UserProvider>(
          builder: (context, provider,_)=>
              StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: provider.getUserById(AuthService.user!.uid),
                  builder: (context,snapshot){
                  if(snapshot.hasData){
                  final userModel = UserModel.fromMap(snapshot.data!.data()!);
                    return DrawerHeader(padding: EdgeInsets.zero, child: UserAccountsDrawerHeader(
                      accountName:  Text(userModel.name ?? "No Display Name"),
                      accountEmail: Text(userModel.email ),
                      currentAccountPicture: Container(
                        height: 100,
                        width: 100,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: userModel.image == null?
                            Image.asset("images/person.png",width: 100, height: 100,fit: BoxFit.cover,):
                            Image.network(userModel.image!,width: 100, height: 100,fit: BoxFit.cover,),
                      ),
                    ))
                    );
                  }
                     if(snapshot.hasError){
                          return const Text("Failed To fetch data");
                      }

                        return const  Center(
                            child: CircularProgressIndicator(),
                        );
                    },
                ),
              ),
                      Card(
                        child: ListTile(
                          onTap: (){
                            Navigator.pushReplacementNamed(context, ChatRoomPage.routeName);
                          },
                          leading: const Icon(Icons.chat),
                          title: const Text("Chat Room"),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          onTap: (){
                            Navigator.pushReplacementNamed(context, ProfilePage.routeName);
                          },
                          leading: const Icon(Icons.person),
                          title: const Text("Profile page"),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          onTap: (){
                            AuthService.logOut().then((value) => Navigator.pushReplacementNamed(context, LauncherPage.routeName));
                          },
                          leading: Icon(Icons.logout),
                          title: Text("Log Out"),
                        ),
                      )
        ],
      ),
    );
  }
}



