abstract class ProductDetailEvent {}

class OnToggleFavoriteEvent extends ProductDetailEvent {}

class OnChangeQuantityEvent extends ProductDetailEvent {
  final int quantity;

  OnChangeQuantityEvent(this.quantity);
}

class OnChangeImageIndexEvent extends ProductDetailEvent {
  final int currentIndex;

  OnChangeImageIndexEvent(this.currentIndex);
}

class OnGetSingleProductEvent extends ProductDetailEvent {
  final int id;

  OnGetSingleProductEvent(this.id);
}

class OnClearProductDetailErrorMessageEvent extends ProductDetailEvent {}
