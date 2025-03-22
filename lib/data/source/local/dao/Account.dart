import 'package:green_cross_test/domain/model/AccountModel.dart';

class Account {
  final int id;
  final String role;
  final int office;

  const Account({
    required this.id,
    required this.role,
    required this.office,
  });

  Map<String, Object> toMap() => {
    'id': id,
    'role': role,
    'office': office,
  };
}