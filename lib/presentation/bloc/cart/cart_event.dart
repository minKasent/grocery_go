import 'package:grocery_go/data/models/params/update_a_cart_param.dart';

abstract class CartEvent {}

class OnGetCartUserEvent extends CartEvent {
  final int id;

  OnGetCartUserEvent(this.id);
}

class OnClearCartErrorMessageEvent extends CartEvent {}

class OnDeleteAProductEvent extends CartEvent {
  final int id;

  OnDeleteAProductEvent(this.id);
}

class OnUpdateACartEvent extends CartEvent {
  final UpdateACartParam params;

  OnUpdateACartEvent(this.params);
}
