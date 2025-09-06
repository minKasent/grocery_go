import 'package:grocery_go/data/models/responses/user_info_dto.dart';
import 'package:grocery_go/domain/entities/user_info_entity.dart';

extension UserInfoMapper on UserInfoDto {
  UserInfoEntity toEntity() {
    return UserInfoEntity(
      email: email ?? '---',
      id: id,
      fullName: _getFullName(),
      image:
          image ??
          "https://cdn.dummyjson.com/products/images/vehicle/Charger%20SXT%20RWD/thumbnail.png",
    );
  }

  String _getFullName() {
    final f = firstName?.trim();
    final l = lastName?.trim();

    if (f == null && l == null) return '---';
    if (f != null && l != null) return '$f $l';

    return f ?? l ?? '---';
  }
}
