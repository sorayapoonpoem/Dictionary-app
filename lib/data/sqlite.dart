import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';

class SqliteHelper {
  Database _db;
  String dbFile = 'lexitron.sqlite';

  // open existing DB or copy from asset folder
  void openDB() async {
    //get the default device's DB folder
    String databasesPath = await getDatabasesPath();
    //create a full path to database file
    String path = join(databasesPath, dbFile);
    print(path);
    // Check if the database exists
    bool exists = await databaseExists(path);
    if (!exists) {
      // DB does not exists, copy it from asset folder
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {
        print('Cannot create folder');
      }

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets/db", dbFile));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
      print('Copying DB done!');
    } else {
      print("Opening existing database");
    }
    // open the database as read only and single instance (prevent db lock due to multiple access)
    _db = await openDatabase(path, readOnly: true, singleInstance: true);
  }

  void closeDB() async {
    // this is not necessary, DB is closed when app ends
    await _db.close();
    print('Database closed');
  }

  void getData() async {
    List<Map> list = await _db.rawQuery('SELECT * FROM eng2th WHERE id = 1');    
    if (list.length > 0) {
      print(list);
    } else {
      print('Not found');
    }
  }
}
