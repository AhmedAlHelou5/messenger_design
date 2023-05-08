import 'package:flutter/material.dart';

class MessengerScreen extends StatefulWidget {
   MessengerScreen({super.key});

  @override
  State<MessengerScreen> createState() => _MessengerScreenState();
}

class _MessengerScreenState extends State<MessengerScreen> {
  final background=const Color(0xFFE8E7E7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/86264396?s=400&u=b11812b1b1ece9611fd4b6274672a8b81aa02f7a&v=4'),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              'Chats',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          CircleAvatar(
              backgroundColor: background,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.camera_alt,
                    color: Colors.black,
                  ))),
          SizedBox(
            width: 10,
          ),
          CircleAvatar(
              backgroundColor: background,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.black,
                  ))),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
             TextField(
                decoration: InputDecoration(
                  fillColor:background ,
                    hintText: 'Search',
                    hintStyle:const TextStyle(color: Colors.grey,),
                    filled: true,
                    prefixIcon:const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(width: 1.0,color: background)

                    ),




              ),
            ),
          ],
        ),
      ),
    );
  }
}
