import 'package:green_cross_test/domain/model/OfficeModel.dart';

class AccountModel {
  final int id;
  final String role;
  final OfficeModel office;

  const AccountModel({
    required this.id,
    required this.office,
    required this.role,
  });
}