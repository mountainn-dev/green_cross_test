import 'package:green_cross_test/data/source/local/dao/Memo.dart';
import 'package:green_cross_test/domain/model/AccountModel.dart';

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