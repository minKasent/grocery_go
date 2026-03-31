import 'package:json_annotation/json_annotation.dart';
part 'login_schema.g.dart';

@JsonSerializable()
class LoginSchema {
  final String username;
  final String password;
  final int expiresInMins;

  LoginSchema({
    required this.username,
    required this.password,
    this.expiresInMins = 30,
  });

  /// toJson
  Map<String, dynamic> toJson() => _$LoginSchemaToJson(this);
}
