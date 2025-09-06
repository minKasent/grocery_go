// {
//     "id": 1,
//     "firstName": "Emily",
//     "lastName": "Johnson",
//     "maidenName": "Smith",
//     "age": 28,
//     "gender": "female",
//     "email": "emily.johnson@x.dummyjson.com",
//     "phone": "+81 965-431-3024",
//     "username": "emilys",
//     "password": "emilyspass",
//     "birthDate": "1996-5-30",
//     "image": "https://dummyjson.com/icon/emilys/128",
//     "bloodGroup": "O-",
//     "height": 193.24,
//     "weight": 63.16,
//     "eyeColor": "Green",
//     "hair": {
//         "color": "Brown",
//         "type": "Curly"
//     },
//     "ip": "42.48.100.32",
//     "address": {
//         "address": "626 Main Street",
//         "city": "Phoenix",
//         "state": "Mississippi",
//         "stateCode": "MS",
//         "postalCode": "29112",
//         "coordinates": {
//             "lat": -77.16213,
//             "lng": -92.084824
//         },
//         "country": "United States"
//     },
//     "macAddress": "47:fa:41:18:ec:eb",
//     "university": "University of Wisconsin--Madison",
//     "bank": {
//         "cardExpire": "03/26",
//         "cardNumber": "9289760655481815",
//         "cardType": "Elo",
//         "currency": "CNY",
//         "iban": "YPUXISOBI7TTHPK2BR3HAIXL"
//     },
//     "company": {
//         "department": "Engineering",
//         "name": "Dooley, Kozey and Cronin",
//         "title": "Sales Manager",
//         "address": {
//             "address": "263 Tenth Street",
//             "city": "San Francisco",
//             "state": "Wisconsin",
//             "stateCode": "WI",
//             "postalCode": "37657",
//             "coordinates": {
//                 "lat": 71.814525,
//                 "lng": -161.150263
//             },
//             "country": "United States"
//         }
//     },
//     "ein": "977-175",
//     "ssn": "900-590-289",
//     "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.93 Safari/537.36",
//     "crypto": {
//         "coin": "Bitcoin",
//         "wallet": "0xb9fc2fe63b2a6c003f1c324c3bfa53259162181a",
//         "network": "Ethereum (ERC20)"
//     },
//     "role": "admin"
// }
/// dto -> Data transfer object
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class UserInfoDto {
  final int id;
  final String? firstName;
  final String? lastName;
  final String? maidenName;
  final int? age;
  final String? gender;
  final String? email;
  final String? phone;
  final String? username;
  final String? password;
  final String? birthDate;
  final String? image;
  final String? bloodGroup;
  final double? height;
  final double? weight;
  final String? eyeColor;
  final HairDto? hair;
  final String? ip;
  final AddressDto? address;
  final String? macAddress;
  final String? university;
  final BankDto? bank;
  final CompanyDto? company;
  final String? ein;
  final String? ssn;
  final String? userAgent;
  final CryptoDto? crypto;
  final String? role;

  const UserInfoDto({
    required this.id,
    this.firstName,
    this.lastName,
    this.maidenName,
    this.age,
    this.gender,
    this.email,
    this.phone,
    this.username,
    this.password,
    this.birthDate,
    this.image,
    this.bloodGroup,
    this.height,
    this.weight,
    this.eyeColor,
    this.hair,
    this.ip,
    this.address,
    this.macAddress,
    this.university,
    this.bank,
    this.company,
    this.ein,
    this.ssn,
    this.userAgent,
    this.crypto,
    this.role,
  });

  factory UserInfoDto.fromJson(Map<String, dynamic> json) =>
      _$UserInfoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoDtoToJson(this);
}

@JsonSerializable()
class HairDto {
  final String? color;
  final String? type;

  const HairDto({this.color, this.type});

  factory HairDto.fromJson(Map<String, dynamic> json) =>
      _$HairDtoFromJson(json);

  Map<String, dynamic> toJson() => _$HairDtoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AddressDto {
  final String? address;
  final String? city;
  final String? state;
  final String? stateCode;
  final String? postalCode;
  final CoordinatesDto? coordinates;
  final String? country;

  const AddressDto({
    this.address,
    this.city,
    this.state,
    this.stateCode,
    this.postalCode,
    this.coordinates,
    this.country,
  });

  factory AddressDto.fromJson(Map<String, dynamic> json) =>
      _$AddressDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDtoToJson(this);
}

@JsonSerializable()
class CoordinatesDto {
  final double? lat;
  final double? lng;

  const CoordinatesDto({this.lat, this.lng});

  factory CoordinatesDto.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesDtoToJson(this);
}

@JsonSerializable()
class BankDto {
  final String? cardExpire;
  final String? cardNumber;
  final String? cardType;
  final String? currency;
  final String? iban;

  const BankDto({
    this.cardExpire,
    this.cardNumber,
    this.cardType,
    this.currency,
    this.iban,
  });

  factory BankDto.fromJson(Map<String, dynamic> json) =>
      _$BankDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BankDtoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CompanyDto {
  final String? department;
  final String? name;
  final String? title;
  final AddressDto? address;

  const CompanyDto({this.department, this.name, this.title, this.address});

  factory CompanyDto.fromJson(Map<String, dynamic> json) =>
      _$CompanyDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyDtoToJson(this);
}

@JsonSerializable()
class CryptoDto {
  final String? coin;
  final String? wallet;
  final String? network;

  const CryptoDto({this.coin, this.wallet, this.network});

  factory CryptoDto.fromJson(Map<String, dynamic> json) =>
      _$CryptoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoDtoToJson(this);
}
