abstract class FavoriteEvent {}

class OnGetFavoriteProductsEvent extends FavoriteEvent {
  final int id;

  OnGetFavoriteProductsEvent({required this.id});
}

class OnClearFavoriteErrorMessageEvent extends FavoriteEvent {}
