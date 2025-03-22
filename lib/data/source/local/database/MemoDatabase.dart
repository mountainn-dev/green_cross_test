import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../dao/Account.dart';
import '../dao/Memo.dart';
import '../dao/Office.dart';
import '../dao/OfficeAccount.dart';

class MemoDatabase {
  static const String _databaseName = "MemoDatabase";
  static const int _databaseVersion = 1;
  static const String TABLE_OFFICE = "offices";
  static const String TABLE_ACCOUNT = "accounts";
  static const String TABLE_MEMO = "memos";
  static late final Database _database;
  static bool _databaseInit = false;

  MemoDatabase() {
    if (!_databaseInit) {
      _initDatabase().then((value) {
        _database = value;
        _databaseInit = true;
      });
    }
  }

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
          'account INTEGER, '
          'createdAt INTEGER, '
          'content TEXT'
          ')',
    );
  }

  Future<Office> createOffice(
      String name,
      String location,
  ) async {
    await _checkDatabase();

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
    await _checkDatabase();

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
        'SELECT office.id AS office_id'
            'office.name AS office_name'
            'office.location AS office_location'
            'account.id AS account_id'
            'account.role AS role'
            'FROM $TABLE_ACCOUNT'
            'INNER JOIN $TABLE_OFFICE ON account.office = office.id'
            'WHERE account.id IS $account.id'
    );

    if (result.isNotEmpty) {
      return OfficeAccount.fromMap(result.first);
    } else {
      throw Exception("no Data");
    }
  }

  Future<Memo> createMemo(
      int author,
      int createdAt,
      String content,
  ) async {
    await _checkDatabase();

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

    return memo;
  }

  Future<void> _checkDatabase() async {
    if (!_databaseInit) {
      await _initDatabase().then((value) {
      _database = value;
      _databaseInit = true;
    });
    }
  }
}