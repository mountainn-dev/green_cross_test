import '../../../../domain/model/AccountModel.dart';
import '../../../../domain/model/OfficeModel.dart';

class OfficeAccount {
  final int accountId;
  final String role;
  final int officeId;
  final String officeName;
  final String officeLocation;

  const OfficeAccount({
    required this.accountId,
    required this.role,
    required this.officeId,
    required this.officeName,
    required this.officeLocation,
  });

  AccountModel toModel() => AccountModel(
    id: accountId,
    role: role,
    office: OfficeModel(
      id: officeId,
      name: officeName,
      location: officeLocation,
    ),
  );

  static OfficeAccount fromMap(Map<String, dynamic> map) => OfficeAccount(
    accountId: map['account_id'],
    role: map['role'],
    officeId: map['office_id'],
    officeName: map['office_name'],
    officeLocation: map['office_location'],
  );
}