import 'package:flutter/material.dart';

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

Widget buildTaskItem(Map model)=>Padding(
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

      Column(
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
      )



    ],

  ),
);