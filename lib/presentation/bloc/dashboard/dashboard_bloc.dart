import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_go/presentation/bloc/dashboard/dashboard_event.dart';
import 'package:grocery_go/presentation/bloc/dashboard/dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardState()) {
    on<OnChangeBottomTabIndex>(_onChangeBottomTabIndex);
  }

  void _onChangeBottomTabIndex(
    OnChangeBottomTabIndex event,
    Emitter<DashboardState> emit,
  ) {
    emit(state.copyWith(currentIndex: event.index));
  }
}
