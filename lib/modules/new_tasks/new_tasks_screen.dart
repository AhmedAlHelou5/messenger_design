import 'package:flutter/material.dart';
import 'package:messenger_design/shared/components/constants.dart';

import '../../shared/components/components.dart';

class NewTasksScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context,index)=>buildTaskItem(tasks[index]),
        separatorBuilder:  (context,index)=>Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey[300],
        ),
        itemCount: tasks.length);

  }
}
