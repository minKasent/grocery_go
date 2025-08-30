import 'package:json_annotation/json_annotation.dart';
part 'login_schema.g.dart';

@JsonSerializable()
class LoginSchema {
  final String username;
  final String password;

  LoginSchema({required this.username, required this.password});

  /// toJson
  Map<String, dynamic> toJson() => _$LoginSchemaToJson(this);
}
