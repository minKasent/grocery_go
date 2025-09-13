// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_a_cart_schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateACartSchema _$UpdateACartSchemaFromJson(Map<String, dynamic> json) =>
    UpdateACartSchema(
      merge: json['merge'] as bool,
      products: (json['products'] as List<dynamic>)
          .map((e) => UpdateAProductSchema.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UpdateACartSchemaToJson(UpdateACartSchema instance) =>
    <String, dynamic>{'merge': instance.merge, 'products': instance.products};

UpdateAProductSchema _$UpdateAProductSchemaFromJson(
  Map<String, dynamic> json,
) => UpdateAProductSchema(
  id: (json['id'] as num).toInt(),
  quantity: json['quantity'] as String,
);

Map<String, dynamic> _$UpdateAProductSchemaToJson(
  UpdateAProductSchema instance,
) => <String, dynamic>{'id': instance.id, 'quantity': instance.quantity};
