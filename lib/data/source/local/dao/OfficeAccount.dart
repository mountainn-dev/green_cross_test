import '../../../../domain/model/AccountModel.dart';
import '../../../../domain/model/OfficeModel.dart';

class OfficeAccount {
  final int accountId;
  final String accountRole;
  final int officeId;
  final String officeName;
  final String officeLocation;

  const OfficeAccount({
    required this.accountId,
    required this.accountRole,
    required this.officeId,
    required this.officeName,
    required this.officeLocation,
  });

  AccountModel toModel() => AccountModel(
    id: accountId,
    role: accountRole,
    office: _officeModel(),
  );

  OfficeModel _officeModel() => OfficeModel(
    id: officeId,
    name: officeName,
    location: officeLocation,
  );

  static OfficeAccount fromMap(Map<String, dynamic> map) => OfficeAccount(
    accountId: map['account_id'],
    accountRole: map['account_role'],
    officeId: map['office_id'],
    officeName: map['office_name'],
    officeLocation: map['office_location'],
  );
}