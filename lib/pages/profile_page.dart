import 'dart:io';

import 'package:chat_app/auth/firebase_auth.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../widget/main_drawer.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/profile';

  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final txtController = TextEditingController();
  bool  isCamera = true;
  @override
  void dispose() {
    // TODO: implement dispose
    txtController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(onPressed: (){
            AuthService.logOut();
            Navigator.pushNamed(context, LoginPage.routeName);
          }, icon: const Icon(Icons.logout))
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
                        Image.asset("images/person.png",width: 200, height: 200,fit: BoxFit.cover,):
                            Image.network(userModel.image!,width: 200, height: 200,fit: BoxFit.cover,),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(onPressed: (){

                            _getImage(ImageSource.camera);
                            },
                              icon: const Icon(Icons.camera), label: const Text("Camera")
                          ),
                          Text("Update Image",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w800),),
                          ElevatedButton.icon(onPressed: (){
                            _getImage(ImageSource.gallery);
                          },
                              icon: const Icon(Icons.photo_album), label: const Text("Gallery")
                          ),
                        ],
                      ),
                      const Divider(color: Colors.black,height: 1,),
                      ListTile(
                        title: Text(userModel.name ?? "No Display Name"),
                        trailing: IconButton(
                          onPressed: (){
                            showInputDialog(
                              title: "Display Name",
                              value: userModel.name,
                              onSaved: (value)async{
                                provider.updateProfile(AuthService.user!.uid,
                                    {'name' : value});
                                await AuthService.updateDisplayName(value);
                              }
                            );
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ),
                      ListTile(
                        title: Text(userModel.email ),
                        trailing: IconButton(
                          onPressed: (){
                            showInputDialog(
                                title: "User Email",
                                value: userModel.email,
                                onSaved: (value)async{
                                  AuthService.updateEmail(value);
                                  provider.updateProfile(AuthService.user!.uid,
                                      {'email' : value});
                                }
                            );
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ),
                      ListTile(
                        title: Text(userModel.mobile ?? "No Mobile Number"),
                        trailing: IconButton(
                          onPressed: (){
                            showInputDialog(
                                title: "Mobile Number",
                                value: userModel.mobile,
                                onSaved: (value){
                                  provider.updateProfile(AuthService.user!.uid,
                                      {'mobile' : value});
                                }
                            );
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      )
                    ],
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
      ),
    );
  }

  showInputDialog({required String title, String? value,required Function(String) onSaved}){
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: Text(title),
      content: Padding(
        padding: const EdgeInsets.all(10),
        child: TextField(
          controller: txtController,
          decoration: InputDecoration(
            hintText: "Enter $title",
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child:const Text("Cancel")),
        TextButton(onPressed: (){
          onSaved(txtController.text);
          Navigator.pop(context);
        }, child: const Text("Update")),
      ],
    ));

  }

  void _getImage(ImageSource source) async {
      final xFile = await ImagePicker().pickImage(source: source, imageQuality: 75);

      if(xFile !=null) {
        final downloadUrl = await Provider.of<UserProvider>(
            context, listen: false).updateImage(File(xFile.path));

        await Provider.of<UserProvider>(context, listen: false).
        updateProfile(AuthService.user!.uid, {'image': downloadUrl});
        await AuthService.updatePhotoUrl(downloadUrl);

    }

  }


}
