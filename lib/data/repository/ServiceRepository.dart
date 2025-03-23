import 'package:green_cross_test/data/source/local/dao/OfficeAccountMemo.dart';
import 'package:green_cross_test/data/source/local/database/MemoDatabase.dart';

import '../../domain/model/AccountModel.dart';
import '../../domain/model/MemoModel.dart';
import '../../domain/model/OfficeModel.dart';
import '../Result.dart';
import '../source/local/dao/Office.dart';
import '../source/local/dao/OfficeAccount.dart';

class ServiceRepository {
  static final _database = MemoDatabase();

  Future<Result<OfficeModel>> createOffice(String name, String location) async {
    try {
      Office data = await _database.createOffice(name, location);
      return Result.success(data.toModel());
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  Future<Result<AccountModel>> createAccount(int office, String role) async {
    try {
      OfficeAccount data = await _database.createAccount(office, role);
      return Result.success(data.toModel());
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  Future<Result<MemoModel>> createMemo(int author, String content) async {
    try {
      OfficeAccountMemo data = await _database.createMemo(author, content);
      return Result.success(data.toModel());
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}