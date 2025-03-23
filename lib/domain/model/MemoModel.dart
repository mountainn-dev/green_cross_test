import 'package:green_cross_test/data/source/local/dao/Memo.dart';
import 'package:green_cross_test/domain/model/AccountModel.dart';

class MemoModels {
  late final List<MemoModel> _models;

  MemoModels(List<MemoModel> models) {
    _models = models;
    _models.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  int size() => _models.length;

  MemoModel get(int index) => _models[index];
}

class MemoModel {
  final int id;
  final AccountModel author;
  final DateTime createdAt;
  final String content;

  const MemoModel({
    required this.id,
    required this.author,
    required this.createdAt,
    required this.content,
  });

  Memo toDao() => Memo(
    id: id,
    author: author.id,
    createdAt: createdAt.millisecondsSinceEpoch,
    content: content
  );
}