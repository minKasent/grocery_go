abstract class FavoriteEvent {}

class OnGetFavoriteProductEvent extends FavoriteEvent {
  final int id;

  OnGetFavoriteProductEvent({required this.id});
}

class OnClearFavoriteErrorMessageEvent extends FavoriteEvent {}

