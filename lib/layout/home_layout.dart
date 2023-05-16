import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:messenger_design/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:messenger_design/modules/done_tasks/done_tasks_screen.dart';
import 'package:messenger_design/modules/new_tasks/new_tasks_screen.dart';
import 'package:messenger_design/shared/components/components.dart';
import 'package:messenger_design/shared/cubit/cubit.dart';
import 'package:messenger_design/shared/cubit/states.dart';
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




  var scaffold = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();


  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          // TODO: implement listener
          if(state is AppInsertDatabaseState){
            Navigator.pop(context);
          }

        },
        builder: (context, state) {
          AppCubit cubit =AppCubit.get(context);
          return Scaffold(
            key: scaffold,
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),

              backgroundColor: Colors.blue,
              title: Text(
                cubit.titles[cubit.currentIndex!],
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDatabaseLoadingState,
              builder: (context) => cubit.screens[cubit.currentIndex!],
              fallback: (context) => Center(child: CircularProgressIndicator()),

            ),
            floatingActionButton: FloatingActionButton(

              onPressed: () {
                // insertToDatabase();
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text);

                  }
                }
                else {
                  scaffold.currentState!.showBottomSheet((context) =>
                      Container(
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
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'title must not be empty';
                                    }
                                    return null;
                                  },
                                  label: 'Task Title',
                                  onTap: () {
                                    print('Task tapped');
                                  },
                                  prefix: Icons.title),


                              SizedBox(height: 15,),

                              defaultFormField(
                                  controller: timeController,
                                  type: TextInputType.datetime,
                                  // isClickable: false,

                                  onTap: () {
                                    showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now()).then((
                                        value) {
                                      timeController.text =
                                          value!.format(context).toString();
                                      print(value!.format(context));
                                    });
                                    print('timing tapped');
                                  },
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
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
                                  onTap: () {
                                    showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse('2023-06-13'))
                                        .then((value) {
                                      dateController.text =
                                          DateFormat.yMMMd().format(value!);

                                      print(value.toString());
                                    });

                                    print('date tapped');
                                  },
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
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
                      elevation: 20).closed.then((value) {
                    cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);


                  });

                  cubit.changeBottomSheetState(isShow: true, icon: Icons.add);




                }
              },
              child: Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex!,
              onTap: (index) {

                cubit.changeIndex(index);

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
        },
      ),
    );
  }



}
