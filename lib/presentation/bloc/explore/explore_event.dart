abstract class ExploreEvent {}

class OnGetCategoryEvent extends ExploreEvent {}

class OnClearExploreErrorMessageEvent extends ExploreEvent {}

class OnSearchCategoryEvent extends ExploreEvent {
  final String query;

  OnSearchCategoryEvent(this.query);
}
