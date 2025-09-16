
abstract class ExploreEvent {}

class OnGetCategoryEvent extends ExploreEvent {
  final String slug;

  OnGetCategoryEvent(this.slug);
}


