import 'package:green_cross_test/domain/model/AccountModel.dart';

import '../../../../domain/model/MemoModel.dart';

class Memo {
  final int id;
  final int author;
  final int createdAt;
  final String content;

  const Memo({
    required this.id,
    required this.author,
    required this.createdAt,
    required this.content,
  });

  Map<String, Object> toMap() => {
    'id': id,
    'author': author,
    'createdAt': createdAt,
    'content': content,
  };

  MemoModel toModel(AccountModel author) => MemoModel(
      author: author,
      content: content,
  );
}