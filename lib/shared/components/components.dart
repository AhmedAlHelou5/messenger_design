import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:messenger_design/shared/cubit/cubit.dart';

Widget defaultButton ({
  double wid = double.infinity,
  double height = 45,
  double radius = 0.0,
  Color background=Colors.blue,
  bool isUpperCase=true,
  required VoidCallback? function,
  required String text,
})=> Container(
  width: wid,
  height: height,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: background,
  ),
  child: MaterialButton(
    onPressed: function,
    
    child:  Text(
     isUpperCase? text.toUpperCase():text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
);

Function()? onSubmit;
Function()? onChange;
Function()? validate;
Function()? onTap;
Widget defaultFormField({

  required  TextEditingController? controller,
  required TextInputType? type,
  required  validate,
  required String? label,
  required IconData? prefix,
  IconData? suffix,
  VoidCallback? suffixPresed,
  onSubmit,
  onTap,
  onChange,
  bool?  isPassword=false,
  bool?  isClickable=true,
})=>TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword!,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
  validator: validate,
  enabled: isClickable,
  onTap: onTap,
  decoration:  InputDecoration(
    labelText: label,
    suffixIcon: suffix != null ? IconButton(icon: Icon(suffix), onPressed: suffixPresed,):null,

    prefixIcon: Icon(
      prefix,
    ),
    focusColor: Colors.blue,

    border: OutlineInputBorder(),
  ),
);

Widget buildTaskItem(Map model,context)=>Dismissible(
  key: Key(model['id'].toString()),
    onDismissed: (directuion){
        AppCubit.get(context).deleteData(id: model['id']);
    },
  child:   Padding(
    padding: const EdgeInsets.all(20),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40.0,
          child: Text(
              '${model['time']}'
          ),
        ),
  
        SizedBox(
          width: 20,
        ),
  
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start ,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${model['title']}',style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),),
              Text('${model['date']}',style: TextStyle(
                  color: Colors.grey
              ),),
            ],
          ),
        ),
        SizedBox(
          width: 20,
        ),
        IconButton(
            onPressed: (){
              AppCubit.get(context).updateData(status: 'done', id: model['id']);
            },
            icon: Icon(Icons.check_box,color: Colors.green,)),
        IconButton(
            onPressed: (){
              AppCubit.get(context).updateData(status: 'archive', id: model['id']);
            },
            icon: Icon(Icons.archive,color: Colors.black45,))
      ],
    ),
  ),
);


Widget tasksBuilder({
 required List<Map> tasks,
})=>ConditionalBuilder(
  condition: tasks.length > 0,
  builder: (BuildContext context) => ListView.separated(
      itemBuilder: (context, index) => buildTaskItem(tasks[index],context),
      separatorBuilder: (context, index) =>
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[300],
          ),
      itemCount: tasks.length),

  fallback: (BuildContext context)=>Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.add_task,
          size: 100,
          color: Colors.grey,
        ),
        Text('No Tasks Yet,Please Add Some Tasks',style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold
        ),)
      ],
    ),
  ),
);




