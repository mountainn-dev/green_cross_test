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

  Future<Result<MemoModels>> readMemo(int office) async {
    try {
      List<OfficeAccountMemo> data = await _database.readMemo(office);
      return Result.success(
          MemoModels(data.map((data) => data.toModel()).toList())
      );
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  Future<Result<void>> deleteMemo(int user, int memo) async {
    try {
      await _database.deleteMemo(user, memo);
      return Result.success(null);
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}