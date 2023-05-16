import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_design/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

import '../../modules/archived_tasks/archived_tasks_screen.dart';
import '../../modules/done_tasks/done_tasks_screen.dart';
import '../../modules/new_tasks/new_tasks_screen.dart';

class AppCubit extends Cubit<AppStates>{

  AppCubit(): super (AppInitialState());
  static AppCubit get(context)=> BlocProvider.of(context);

  late Database database;
  int? currentIndex = 0;
  List<Map>newtasks=[];
  List<Map>donetasks=[];
  List<Map>archivetasks=[];
  IconData fabIcon = Icons.edit;
  bool isBottomSheetShown = false;


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

void changeIndex(int index){
  currentIndex = index;
  emit(AppChangeBottomNavBarState());

}


  void createDatabase()  {
    openDatabase('todo.db', version: 1,
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
              getDataFromDatabase(database);

          print('database opened');
        }).then((value) {
          database=value;
          emit(AppCreateDatabaseState());
    });
  }

   insertToDatabase({
        required String title, required String time, required String date
      }) async{

     await database.transaction((txn) =>
        txn.rawInsert(
            'INSERT INTO tasks (title,date,time,status) VALUES("$title","$date","$time","new")'
        ).then((value) {
          print('$value inserted successfully');
          emit(AppInsertDatabaseState());

          getDataFromDatabase(database);

        }).catchError((error) {
          print('error when  inserting New Row ${error.toString()} ');
        }));
  }


  void getDataFromDatabase(database)  {

  newtasks=[];
  donetasks=[];
  archivetasks=[];

  emit(AppGetDatabaseLoadingState());
    database.rawQuery('select * from tasks ').then((value) {
      value.forEach((element) {
        print(element['status']);

        if (element['status'] == 'new'){
          newtasks.add(element);
        }else if (element['status'] == 'done'){
          donetasks.add(element);
        }else{
          archivetasks.add(element);
        }

      });
      emit(AppGetDatabaseState());

    });
  }

  void changeBottomSheetState({
  required bool isShow,
  required IconData icon,
    }){
  isBottomSheetShown=isShow;
  fabIcon=icon;
  emit(AppchangeBottomSheetState());

  }

  // Update some record

  void updateData({
  required String status,
  required int id
})async{
     database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
          getDataFromDatabase(database);

       emit(AppUpdateValuesDatabaseState());

     });
  }

  void deleteData({
    required int id
  })async{
    database.rawDelete(

        'DELETE FROM Tasks WHERE id = ? ', [id]).then((value) {
      getDataFromDatabase(database);

      emit(AppDeleteDatabaseState());

    });
  }



}
