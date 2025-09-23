import 'package:grocery_go/data/models/requests/update_a_cart_schema.dart';

class UpdateACartParam {
  final UpdateACartSchema schema;
  final int id;

  const UpdateACartParam({required this.schema, required this.id});
}
