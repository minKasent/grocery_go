abstract class CategoryProductEvent {}

class OnFetchListOfProductsEvent extends CategoryProductEvent {
  final String slug;

  OnFetchListOfProductsEvent(this.slug);
}

class OnClearCategoryProductErrorMessageEvent extends CategoryProductEvent {}
