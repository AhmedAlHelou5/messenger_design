import 'package:flutter/material.dart';

class MessengerScreen extends StatefulWidget {
  const MessengerScreen({super.key});

  @override
  State<MessengerScreen> createState() => _MessengerScreenState();
}

class _MessengerScreenState extends State<MessengerScreen> {
  final background = const Color(0xFFE8E7E7);

  Widget buildChatItem() => Row(
        children: [
          const Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    'https://avatars.githubusercontent.com/u/86264396?s=400&u=b11812b1b1ece9611fd4b6274672a8b81aa02f7a&v=4'),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 3.0,
                ),
                child: CircleAvatar(
                  radius: 6.0,
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ahmed Hatem Al-Helou ',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'hello my name is  Ahmed Hatem Al-Helou',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                            color: Colors.blue, shape: BoxShape.circle),
                      ),
                    ),
                    const Text('02:00 pm')
                  ],
                )
              ],
            ),
          ),
        ],
      );

  Widget buildStoryItem() => SizedBox(
        width: 60,
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      'https://avatars.githubusercontent.com/u/86264396?s=400&u=b11812b1b1ece9611fd4b6274672a8b81aa02f7a&v=4'),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 3.0,
                  ),
                  child: CircleAvatar(
                    radius: 6.0,
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                'Ahmed Hatem Al-Helou',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      );

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
          const SizedBox(
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 45,
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: background,
                    hintText: 'Search',
                    hintStyle:
                        const TextStyle(color: Colors.black54, height: 1),
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.black54,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                            width: 1,
                            style: BorderStyle.solid,
                            color: background)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                            width: 1,
                            style: BorderStyle.solid,
                            color: background)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                            width: 1,
                            style: BorderStyle.solid,
                            color: background)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                      return buildStoryItem();
                    },
                    itemCount: 6,
                  separatorBuilder: (BuildContext context, int index) => SizedBox(width: 20,),),
              ),
               SizedBox(
                height: 20,
              ),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context,index){
                    return buildChatItem();
                  },
                  itemCount: 15,
                  separatorBuilder: (BuildContext context, int index) => SizedBox(height: 20,),),

            ],
          ),
        ),
      ),
    );
  }
}
