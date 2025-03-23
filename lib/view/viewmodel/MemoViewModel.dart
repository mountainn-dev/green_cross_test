import 'package:flutter/cupertino.dart';
import 'package:green_cross_test/data/Result.dart' as R;
import 'package:green_cross_test/data/repository/ServiceRepository.dart';
import 'package:green_cross_test/view/state/UiState.dart' as U;

import '../../../domain/model/OfficeModel.dart';
import '../../data/Result.dart';
import '../../domain/model/AccountModel.dart';
import '../../domain/model/MemoModel.dart';
import '../state/UiState.dart';

class MemoViewModel {
  late final _repository = ServiceRepository();

  late final AccountModel _user;
  AccountModel get user => _user;

  late final OfficeModel _office;
  OfficeModel get office => _office;

  MemoModels get memos => _memos;
  late MemoModels _memos;

  String get error => _error;
  late String _error;

  final TextEditingController memoContentController = TextEditingController();

  MemoViewModel();

  Future<void> init(
      String officeName,
      String officeLocation,
      String userRole,
  ) async {
    await _createOffice(officeName, officeLocation);
    await _createAccount(userRole);
    await _loadMemo();
  }

  Future<void> _createOffice(
    String name,
    String location,
  ) async {
    Result result = await _repository.createOffice(name, location);

    if (result is R.Success) {
      _office = result.data;
    }
  }

  Future<void> _createAccount(
    String role,
  ) async {
    Result result = await _repository.createAccount(_office.id, role);

    if (result is R.Success) {
      _user = result.data;
    }
  }

  Future<UiState> createMemoAndLoad() async {
    Result result = await _repository.createMemo(_user.id, memoContentController.text);

    if (result is R.Success) {
      memoContentController.clear();
      return await _loadMemo();
    } else {
      _error = (result as R.Error).message;
      return U.Error();
    }
  }

  Future<UiState> _loadMemo() async {
    Result result = await _repository.readMemo(_office.id);

    if (result is R.Success) {
      _memos = result.data;
      return U.Success();
    } else {
      _error = (result as R.Error).message;
      return U.Error();
    }
  }

  Future<UiState> deleteMemo(MemoModel memo) async {
    Result result = await _repository.deleteMemo(_user.id, memo.id);

    if (result is R.Success) {
      return await _loadMemo();
    } else {
      _error = (result as R.Error).message;
      return U.Error();
    }
  }
}