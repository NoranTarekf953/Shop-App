// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:shop_app/states.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIntialStates());
  static AppCubit get(context) => BlocProvider.of(context);

  int currentindex = 0;
  List<Widget> screens = [
    //const NewTasks(),
    //const DoneTasks(),
    //const ArchivedTasks()
  ];
  List title = ['New Tasks', 'Done Tasks', 'Archieved Tasks'];
  late Database database;
  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archivetasks = [];

  void changeIndex(int index) {
    currentindex = index;
    emit(AppChangeBottomNavBar());
  }

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (db, version) {
        print('database created');
        db.execute('''
        CREATE TABLE tasks
        (id INTEGER PRIMARY KEY ,
        title TEXT,
        date TEXT,
        time TEXT,
        status TEXT)''').then((value) {
          print('table created');
        }).catchError((error) {
          print('error is ..... ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDatafromDB(database);
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDBState());
    });
  }

  insertDatabase(
      {required String title,
      required String date,
      required String time}) async {
    await database.transaction((txn) async {
      txn.rawInsert('''
INSERT INTO tasks(
  title,date,time,status
)VALUES(
  "$title","$date","$time","new"
)
''').then((value) {
        print('$value inserted successfully');
        emit(AppInsertDBState());
        getDatafromDB(database);
      }).catchError((e) {
        print("error is $e");
      });
      return null;
    });
  }

  void getDatafromDB(database) {
    newtasks = [];
    donetasks = [];
    archivetasks = [];
    emit(AppGetDBLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newtasks.add(element);
        } else if (element['status'] == 'done') {
          donetasks.add(element);
        } else {
          archivetasks.add(element);
        }
      });
      emit(AppGetDBState());
      print(value);
    });
    
  }

  void updateDB({required String status, required int id}) {
    database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?', [status, id]).then((value) {
      getDatafromDB(database);
      emit(AppUpdateDBState());
    });
  }

  void deleteDB({required int id}) {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]);
    getDatafromDB(database);
    emit(AppDeleteDBState());
  }

  bool isBottomSheetShown = false;
  var fabIcon = Icons.edit;

  changeBottomSheet({required bool isShow, required IconData icon}) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetNavBar());
  }


    bool isDark = false;

  void changeMood({ bool? sharedpref}) {
    if (sharedpref != null) {
      isDark = sharedpref;
      emit(NewsChangeMoodState());
    } else {
      isDark = !isDark;
       CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
      emit(NewsChangeMoodState());
    });
    }
   
  }
}
