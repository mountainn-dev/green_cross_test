import 'package:green_cross_test/data/Result.dart';
import 'package:green_cross_test/data/repository/ServiceRepository.dart';

import '../../../domain/model/OfficeModel.dart';
import '../../domain/model/AccountModel.dart';

class MemoViewModel {
  late final repository = ServiceRepository();

  late final AccountModel _user;
  AccountModel get user => _user;

  late final OfficeModel _office;
  OfficeModel get office => _office;

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

    if (result is Success) {
      _office = result.data;
    }
  }

  Future<void> _createAccount(
      String role,
  ) async {
    await repository.createAccount(_office.id, role);
  }
}