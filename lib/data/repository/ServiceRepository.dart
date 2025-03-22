import 'package:green_cross_test/data/source/local/database/MemoDatabase.dart';

import '../../domain/model/AccountModel.dart';
import '../../domain/model/MemoModel.dart';
import '../../domain/model/OfficeModel.dart';
import '../Result.dart';
import '../source/local/dao/Account.dart';
import '../source/local/dao/Memo.dart';
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

  // Future<Result<MemoModel>> create(MemoModel memo) async {
  //   try {
  //     Memo data = await _database.create(memo.toDao());
  //
  //     return Result.success(data.);
  //   } catch (e) {
  //
  //   }
  // }
}