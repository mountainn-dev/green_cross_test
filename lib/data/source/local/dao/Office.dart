import 'package:green_cross_test/domain/model/AccountModel.dart';
import 'package:green_cross_test/domain/model/OfficeModel.dart';

import '../../../../domain/model/MemoModel.dart';

class Office {
  final int id;
  final String name;
  final String location;

  const Office({
    required this.id,
    required this.name,
    required this.location,
  });

  Map<String, Object> toMap() => {
    'id': id,
    'name': name,
    'location': location,
  };

  OfficeModel toModel() => OfficeModel(
    id: id,
    name: name,
    location: location,
  );
}