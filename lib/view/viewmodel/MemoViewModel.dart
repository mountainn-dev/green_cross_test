import '../../../domain/model/OfficeModel.dart';

class MemoViewModel {
  late final OfficeModel _office;
  OfficeModel get office => _office;

  MemoViewModel(OfficeModel office) {
    _office = office;
  }
}