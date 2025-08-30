import 'package:grocery_go/data/models/responses/login_dto.dart';
import 'package:grocery_go/domain/entities/login_entity.dart';

extension LoginMapper on LoginDto {
  LoginEntity toEntity() {
    return LoginEntity(
      email: email,
      id: id,
      username: username,
      fullName: firstName + lastName,
      gender: gender,
      image: image,
      accessToken: accessToken,
    );
  }
}
