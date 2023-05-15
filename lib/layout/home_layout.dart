import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:messenger_design/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:messenger_design/modules/done_tasks/done_tasks_screen.dart';
import 'package:messenger_design/modules/new_tasks/new_tasks_screen.dart';
import 'package:messenger_design/shared/components/components.dart';
import 'package:sqflite/sqflite.dart';

import '../shared/components/constants.dart';
// 1. create database
// 2. create tables
// 3. open database
// 4. insert to database
// 5. get from  database
// 6. update in  database
// 7. delete from database
class HomeLayout extends StatelessWidget {





  int? currentIndex = 0;

  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen()
  ];

  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];



  late Database database;
   bool isBottomSheetShown =false;
  var scaffold = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  IconData fabIcon = Icons.edit ;
  var titleController =TextEditingController();
  var timeController =TextEditingController();
  var dateController =TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),

        backgroundColor: Colors.blue,
        title: Text(
          titles[currentIndex!],
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ConditionalBuilder(
        condition:  tasks.length>0,
        builder: (context)=>screens[currentIndex!],
        fallback: (context)=>Center(child: CircularProgressIndicator()),

      ) ,
      floatingActionButton: FloatingActionButton(

        onPressed: () {
          // insertToDatabase();
          if(isBottomSheetShown){
            if(formKey.currentState!.validate()){

              insertToDatabase(
                  title: titleController.text,
                  time: timeController.text,
                  date: dateController.text).then((value) {


                getDataFromDatabase(database).then((value) {
                  Navigator.pop(context);
                  // setState(() {
                    tasks =value;
                    fabIcon = Icons.edit;
                    isBottomSheetShown=false;

                  // });
                  print(tasks);

                }
                );

                  });


            }
          }
          else{
            scaffold.currentState!.showBottomSheet((context) => Container(
              padding: const EdgeInsets.all(20.0),
                color: Colors.white,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      defaultFormField(
                          controller: titleController,
                          type: TextInputType.text,
                          validate: (String? value){
                            if(value!.isEmpty){
                              return 'title must not be empty';
                            }
                            return null;
                          },
                          label: 'Task Title',
                          onTap: (){
                            print('Task tapped');
                          },
                          prefix: Icons.title),


                      SizedBox(height: 15,),

                      defaultFormField(
                          controller: timeController,
                          type: TextInputType.datetime,
                          // isClickable: false,

                          onTap: (){
                            showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now()).then((value){
                                  timeController.text=value!.format(context).toString();
                              print(value!.format(context));

                            });
                            print('timing tapped');
                          },
                          validate: (String? value){
                            if(value!.isEmpty){
                              return 'time must not be empty';
                            }
                            return null;
                          },
                          label: 'Task Time',
                          prefix: Icons.watch_later_outlined),


                      SizedBox(height: 15,),

                      defaultFormField(
                          controller: dateController,
                          type: TextInputType.datetime,
                          // isClickable: false,
                          onTap: (){
                            showDatePicker(
                                context: context,
                                initialDate:DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.parse('2023-06-13')).then((value) {
                              dateController.text=DateFormat.yMMMd().format(value!);

                                  print(value.toString());
                            });

                            print('date tapped');
                          },
                          validate: (String? value){
                            if(value!.isEmpty){
                              return 'date must not be empty';
                            }
                            return null;
                          },
                          label: 'Task date',
                          prefix: Icons.calendar_month),




                    ],
                  ),
                ),

            ),
                elevation: 20).closed.then((value)  {
              isBottomSheetShown=false;
              // setState(() {
                fabIcon = Icons.edit;
              // });
            });
            isBottomSheetShown=true;
            // setState(() {
              fabIcon = Icons.add;

            // });


          }

            

        },
        child:  Icon(fabIcon),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex!,
        onTap: (index) {
          // setState(() {
            currentIndex = index;
          // });
          print(index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.check_circle_outline), label: 'Done'),
          BottomNavigationBarItem(
              icon: Icon(Icons.archive_outlined), label: 'Archived'),
        ],
      ),
    );
  }

  void createDatabase() async {
    database = await openDatabase('todo.db', version: 1,
        onCreate: (database, version) {
      print('database created');
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
          .then((value) {
        print('table created');
        print(database.toString());
      }).catchError((onError) {
        print('Error When Create Table ${onError.toString()}');
      });
    }, onOpen: (database) {

      print('database opened');
    });
  }

  Future insertToDatabase({required String title,required String time,required String date} ) async {
  return await database.transaction((txn) => txn.rawInsert(
          'INSERT INTO tasks (title,date,time,status) VALUES("$title","$date","$time","new")'
      ).then((value) {




        print('$value inserted successfully');
      }).catchError((error) {
        print('error when  inserting New Row ${error.toString()} ');
      }));
  }


  Future<List<Map>> getDataFromDatabase(database)async{
  return await database.rawQuery('select * from tasks ');
  }



}
