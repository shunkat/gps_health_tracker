import 'package:freezed_annotation/freezed_annotation.dart';

part 'User.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required String uid,
    required String nickName,
    required String deviceId,
  }) = _User;

  // JSONのシリアライズとデシリアライズを追加する場合
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
