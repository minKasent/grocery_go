import 'package:json_annotation/json_annotation.dart';

part 'update_a_cart_schema.g.dart';

// {
//     "merge": true,
//     "products": [
//         {
//             "id": 44,å
//             "quantity": "6"å
//         }
//     ]
// }

@JsonSerializable()
class UpdateACartSchema {
  final bool merge;
  final List<UpdateAProductSchema> products;

  UpdateACartSchema({required this.merge, required this.products});

  factory UpdateACartSchema.fromJson(Map<String, dynamic> json) =>
      _$UpdateACartSchemaFromJson(json);

  /// toJson
  Map<String, dynamic> toJson() => _$UpdateACartSchemaToJson(this);
}

@JsonSerializable()
class UpdateAProductSchema {
  final int id;
  final String quantity;

  UpdateAProductSchema({required this.id, required this.quantity});

  factory UpdateAProductSchema.fromJson(Map<String, dynamic> json) =>
      _$UpdateAProductSchemaFromJson(json);

  /// toJson
  Map<String, dynamic> toJson() => _$UpdateAProductSchemaToJson(this);
}
