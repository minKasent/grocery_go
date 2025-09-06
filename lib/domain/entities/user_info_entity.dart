import 'package:equatable/equatable.dart';

class UserInfoEntity extends Equatable {
  final int id;
  final String fullName;
  final String email;
  final String image;

  const UserInfoEntity({
    required this.id,
    required this.email,
    required this.fullName,
    required this.image,
  });

  @override
  List<Object?> get props => [id, email, fullName, image];
}
