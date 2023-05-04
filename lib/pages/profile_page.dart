import 'package:chat_app/auth/firebase_auth.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
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
      body: Center(
        child: Consumer<UserProvider>(
          builder: (context, provider,_)=>
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: provider.getUserById(AuthService.user!.uid),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  final userModel = UserModel.fromMap(snapshot.data!.data()!);
                  return ListView(
                    children: [
                      Center(
                        child: userModel.image == null?
                        Image.asset("images/person.png",width: 100, height: 100,fit: BoxFit.cover,):
                            Image.network(userModel.image!,width: 100, height: 100,fit: BoxFit.cover,),
                      ),
                      ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.camera), label: Text("Update Camera")),
                      const Divider(color: Colors.black,height: 1,),
                      ListTile(
                        title: Text(userModel.name ?? "No Display Name"),
                        trailing: IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.edit),
                        ),
                      ),
                      ListTile(
                        title: Text(userModel.email ),
                        trailing: IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.edit),
                        ),
                      ),
                      ListTile(
                        title: Text(userModel.mobile ?? "No Mobile Number"),
                        trailing: IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.edit),
                        ),
                      )
                    ],
                  );
                }
                if(snapshot.hasError){
                  return Text("Failed To fetch data");
                }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
              },
            ),
        ),
      ),
    );
  }
}
