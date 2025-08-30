// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginSchema _$LoginSchemaFromJson(Map<String, dynamic> json) => LoginSchema(
  username: json['username'] as String,
  password: json['password'] as String,
);

Map<String, dynamic> _$LoginSchemaToJson(LoginSchema instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };
