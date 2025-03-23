import 'package:flutter/cupertino.dart';
import 'package:green_cross_test/data/Result.dart' as R;
import 'package:green_cross_test/data/repository/ServiceRepository.dart';

import '../../../domain/model/OfficeModel.dart';
import '../../data/Result.dart';
import '../../domain/model/AccountModel.dart';
import '../state/UiState.dart' as U;

class MemoViewModel {
  late final repository = ServiceRepository();

  late final AccountModel _user;
  AccountModel get user => _user;

  late final OfficeModel _office;
  OfficeModel get office => _office;

  final TextEditingController memoContentController = TextEditingController();

  MemoViewModel();

  Future<void> init(
      String officeName,
      String officeLocation,
      String userRole,
  ) async {
    await _createOffice(officeName, officeLocation);
    await _createAccount(userRole);
  }

  Future<void> _createOffice(
    String name,
    String location,
  ) async {
    Result result = await repository.createOffice(name, location);

    if (result is R.Success) {
      _office = result.data;
    }
  }

  Future<void> _createAccount(
    String role,
  ) async {
    Result result = await repository.createAccount(_office.id, role);

    if (result is R.Success) {
      _user = result.data;
    }
  }

  Future<U.UiState> createMemo() async {
    Result result = await repository.createMemo(_user.id, memoContentController.text);

    if (result is R.Success) {
      return U.Success(data: result.data);
    } else {
      return U.Error(message: (result as R.Error).message);
    }
  }
}