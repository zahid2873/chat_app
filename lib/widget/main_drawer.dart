import 'package:chat_app/auth/firebase_auth.dart';
import 'package:chat_app/pages/chat_room_page.dart';
import 'package:chat_app/pages/profile_page.dart';
import 'package:flutter/material.dart';

import '../pages/launcher_page.dart';

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
          // DrawerHeader(padding: EdgeInsets.zero, child: UserAccountsDrawerHeader(
          //   accountName: const Text(userModel.),
          //   accountEmail: Text("billgates96@gmail.com"),
          //   currentAccountPicture: Container(
          //     height: 100,
          //     width: 100,
          //     child: ClipRRect(
          //         borderRadius: BorderRadius.circular(60),
          //         child: Image.network('http://t1.gstatic.com/licensed-image?q=tbn:ANd9GcQi4a8NzG1ocCbgUUZxxDLocQwDQvhod4gHC3aRRg3juK0LDsZHECn7AwMJq8WUmPFLai9IJhY5YWNLRys',fit: BoxFit.cover,)),
          //   ),
          // )),

          ListTile(
            onTap: (){
              Navigator.pushReplacementNamed(context, ChatRoomPage.routeName);
            },
            leading: const Icon(Icons.chat),
            title: const Text("Chat Room"),
          ),
          ListTile(
            onTap: (){
              Navigator.pushReplacementNamed(context, ProfilePage.routeName);
            },
            leading: const Icon(Icons.person),
            title: const Text("Profile page"),
          ),
          ListTile(
            onTap: (){
              AuthService.logOut().then((value) => Navigator.pushReplacementNamed(context, LauncherPage.routeName));
            },
            leading: Icon(Icons.logout),
            title: Text("Log Out"),
          )
        ],
      ),
    );
  }
}
