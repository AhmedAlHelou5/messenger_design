import 'package:flutter/material.dart';

import 'model/user_model.dart';

class UsersScreen extends StatelessWidget {

  List<UserModel> users =[
    UserModel(id: 1, name: 'Ahmed Al-Helou', phone: '+970592722192'),
    UserModel(id: 2, name: 'Ahmed Al-Helou', phone: '+970592722192'),
    UserModel(id: 3, name: 'Ahmed Al-Helou', phone: '+970592722199'),
    UserModel(id: 4, name: 'Ahmed Hatem Al-Helou', phone: '+970592722192'),
    UserModel(id: 5, name: 'Ahmed Al-Helou', phone: '+970592722192'),
    UserModel(id: 6, name: 'Ahmed Al-Helou', phone: '+970592722196'),
    UserModel(id: 7, name: 'Ahmed Al-Helou', phone: '+970592722197'),
    UserModel(id: 8, name: 'Ahmed Al-Helou', phone: '+970592722195'),
    UserModel(id: 9, name: 'Ahmed Hatem Al-Helou', phone: '+970592722194'),
    UserModel(id: 10, name: 'Ahmed Al-Helou', phone: '+970592722191'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Users'),
      ),
      body: ListView.separated(
          itemBuilder: (context,index)=>buildUserItem(users[index]),
          separatorBuilder: (context,index)=>Padding(
            padding: EdgeInsetsDirectional.only(start: 20),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          itemCount: users.length),
    );
  }

  Widget buildUserItem(UserModel user)=> Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            child: Text(
              '${user.id}',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
        const  SizedBox(
            width: 20,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
               ' ${user.name}',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                '${user.phone}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );

}
