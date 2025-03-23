import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../dao/Account.dart';
import '../dao/Memo.dart';
import '../dao/Office.dart';
import '../dao/OfficeAccount.dart';
import '../dao/OfficeAccountMemo.dart';

class MemoDatabase {
  static const String _databaseName = "MemoDatabase";
  static const int _databaseVersion = 1;
  static const String TABLE_OFFICE = "offices";
  static const String TABLE_ACCOUNT = "accounts";
  static const String TABLE_MEMO = "memos";

  static late final Database _database;
  static bool _databaseInit = false;
  Future<Database> get database async {
    if (_databaseInit) return _database;

    _database = await _initDatabase();
    _databaseInit = true;
    return _database;
  }

  MemoDatabase();

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);

    return openDatabase(
      path,
      onCreate: (db, _) async {
        await Future.wait([
          initOfficeTable(db),
          initAccountTable(db),
          initMemoTable(db),
        ]);
      },
      version: _databaseVersion,
    );
  }

  Future<void> initOfficeTable(Database db) async {
    await db.execute(
      'CREATE TABLE $TABLE_OFFICE ('
          'id INTEGER PRIMARY KEY, '
          'name TEXT, '
          'location TEXT )',
    );
  }

  Future<void> initAccountTable(Database db) async {
    await db.execute(
      'CREATE TABLE $TABLE_ACCOUNT ('
          'id INTEGER PRIMARY KEY, '
          'office INTEGER, '
          'role TEXT )',
    );
  }

  Future<void> initMemoTable(Database db) async {
    await db.execute(
      'CREATE TABLE $TABLE_MEMO ('
          'id INTEGER PRIMARY KEY, '
          'author INTEGER, '
          'createdAt INTEGER, '
          'content TEXT )',
    );
  }

  Future<Office> createOffice(
      String name,
      String location,
  ) async {
    await database;

    Office office = Office(
      id: name.hashCode ^ location.hashCode,
      name: name,
      location: location,
    );

    await _database.insert(
      TABLE_OFFICE,
      office.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return office;
  }

  Future<OfficeAccount> createAccount(
      int office,
      String role,
  ) async {
    await database;

    Account account = Account(
      id: office ^ role.hashCode,
      office: office,
      role: role,
    );

    await _database.insert(
      TABLE_ACCOUNT,
      account.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    List<Map<String, dynamic>> result = await _database.rawQuery(
        'SELECT $TABLE_ACCOUNT.id AS account_id, '
            '$TABLE_ACCOUNT.role AS account_role, '
            '$TABLE_OFFICE.id AS office_id, '
            '$TABLE_OFFICE.name AS office_name, '
            '$TABLE_OFFICE.location AS office_location '
            'FROM $TABLE_ACCOUNT '
            'INNER JOIN $TABLE_OFFICE ON $TABLE_ACCOUNT.office = $TABLE_OFFICE.id '
            'WHERE $TABLE_ACCOUNT.id = ${account.id}'
    );

    if (result.isNotEmpty) {
      return OfficeAccount.fromMap(result.first);
    } else {
      throw Exception("no Data");
    }
  }

  Future<OfficeAccountMemo> createMemo(
      int author,
      String content,
  ) async {
    await database;

    int createdAt = DateTime.now().millisecondsSinceEpoch;
    Memo memo = Memo(
      id: author ^ createdAt.hashCode,
      author: author,
      createdAt: createdAt,
      content: content,
    );

    await _database.insert(
      TABLE_MEMO,
      memo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    List<Map<String, dynamic>> result = await _database.rawQuery(
        'SELECT $TABLE_MEMO.id AS memo_id, '
            '$TABLE_MEMO.createdAt AS memo_created_at, '
            '$TABLE_MEMO.content AS memo_content, '
            '$TABLE_ACCOUNT.id AS account_id, '
            '$TABLE_ACCOUNT.role AS account_role, '
            '$TABLE_OFFICE.id AS office_id, '
            '$TABLE_OFFICE.name AS office_name, '
            '$TABLE_OFFICE.location AS office_location '
            'FROM $TABLE_MEMO '
            'INNER JOIN $TABLE_ACCOUNT ON $TABLE_MEMO.author = $TABLE_ACCOUNT.id '
            'INNER JOIN $TABLE_OFFICE ON $TABLE_ACCOUNT.office = $TABLE_OFFICE.id '
            'WHERE $TABLE_MEMO.id = ${memo.id}'
    );

    if (result.isNotEmpty) {
      return OfficeAccountMemo.fromMap(result.first);
    } else {
      throw Exception("no Data");
    }
  }
}