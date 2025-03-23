import '../../../../domain/model/AccountModel.dart';
import '../../../../domain/model/MemoModel.dart';
import '../../../../domain/model/OfficeModel.dart';

class OfficeAccountMemo {
  final int memoId;
  final int authorId;
  final String authorRole;
  final int createdAt;
  final String content;
  final int officeId;
  final String officeName;
  final String officeLocation;

  const OfficeAccountMemo ({
    required this.memoId,
    required this.authorId,
    required this.authorRole,
    required this.createdAt,
    required this.content,
    required this.officeId,
    required this.officeName,
    required this.officeLocation,
  });

  MemoModel toModel() => MemoModel(
    id: memoId,
    author: _authorModel(),
    createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
    content: content
  );

  AccountModel _authorModel() => AccountModel(
    id: authorId,
    role: authorRole,
    office: OfficeModel(
      id: officeId,
      name: officeName,
      location: officeLocation,
    ),
  );

  static OfficeAccountMemo fromMap(Map<String, dynamic> map) => OfficeAccountMemo(
    memoId: map['memo_id'],
    authorId: map['account_id'],
    authorRole: map['account_role'],
    createdAt: map['memo_created_at'],
    content: map['memo_content'],
    officeId: map['office_id'],
    officeName: map['office_name'],
    officeLocation: map['office_location'],
  );
}