import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final int id;
  final String username;
  final String email;
  final String fullName;
  final String gender;
  final String image;
  final String accessToken;

  const LoginEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.fullName,
    required this.gender,
    required this.image,
    required this.accessToken,
  });

  @override
  List<Object?> get props => [
    id,
    username,
    email,
    fullName,
    gender,
    image,
    accessToken,
  ];
}
