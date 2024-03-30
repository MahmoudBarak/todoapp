import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/Cubit/AppCubit/app_state.dart';


class AppCubit extends Cubit<AppState> {
  AppCubit() : super(InitialState());
  Database? dataBase;

  List<Map> data = [];
  int currentPage=0;
  int tasksPerPage=5;
  int startPage=0;

  createDataBase() async {
    dataBase = await openDatabase('toTod.db', version: 1,
        onCreate: (database, version) {
      emit(DataBaseCreatedSuccess());
      print('dataBase Created');
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY , task TEXT ,date TEXT , time TEXT)')
          .then((value) {
        print('TABLE CREATED');
      }).catchError((error) {
        print('ERROR WHEN TABLE CREATED::: ${error.toString()}');
      });
    }, onOpen: (database) {
      getData(database).then((valu){
        data=valu;
        emit(GetData());
        print(data);
      });
      print('dataBase opened');
    });
  }

  insertIntoDataBase(
      {required String task,
      required String time,
      required String date}) async {
    return await dataBase!.transaction((txn) async {
      await txn
          .rawInsert(
              'INSERT INTO tasks (task , time , date ) VALUES ("$task","$time","$date") ')
          .then((value) {
        print(value);
        emit(DataInsertSuccess());
        print("insert Success");
        getData(dataBase).then((valu){
          data=valu;
          emit(GetData());
          print(data);
        });
      }).catchError((error) {
        print("error happened when insert${error.toString()} ");
        emit(DataInsertFailure());
      });
    });
  }

  Future<List<Map>>getData(database) async {
   return await database.rawQuery('SELECT * FROM tasks');
  }

}
