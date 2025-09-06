import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_go/core/assets_gen/assets.gen.dart';
import 'package:grocery_go/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'package:grocery_go/presentation/bloc/dashboard/dashboard_event.dart';
import 'package:grocery_go/presentation/bloc/dashboard/dashboard_state.dart';
import 'package:grocery_go/presentation/screens/account/account_screen.dart';
import 'package:grocery_go/presentation/screens/favorite_screen/favorite_screen.dart';
import 'package:grocery_go/presentation/theme/app_color_schemes.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc(),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(
              index: state.currentIndex,
              children: [
                Container(),
                Container(),
                Container(),
                FavoriteScreen(),
                AccountScreen(),
              ],
            ),
            bottomNavigationBar: _buildBottomNavigationBarWidget(
              context,
              state: state,
            ),
          );
        },
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBarWidget(
    BuildContext context, {
    required DashboardState state,
  }) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      // backgroundColor: context.theme.bottomNavigationBarTheme.backgroundColor,
      selectedItemColor: AppColorSchemes.green,
      unselectedItemColor: AppColorSchemes.black,
      elevation: 10,
      currentIndex: state.currentIndex,
      onTap: (index) {
        context.read<DashboardBloc>().add(OnChangeBottomTabIndex(index));
      },
      items: [
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(Assets.icons.storeIc.path)),
          label: 'Shop',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(Assets.icons.exploreIc.path)),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(Assets.icons.cartIc.path)),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(Assets.icons.favoriteIc.path)),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(Assets.icons.userInfoIc.path)),
          label: 'Account',
        ),
      ],
    );
  }
}
