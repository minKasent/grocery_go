abstract class DashboardEvent {}

class OnChangeBottomTabIndex extends DashboardEvent {
  final int index;

  OnChangeBottomTabIndex(this.index);
}
