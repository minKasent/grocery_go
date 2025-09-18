import 'package:go_router/go_router.dart';
import 'package:grocery_go/domain/entities/product_entity.dart';
import 'package:grocery_go/presentation/routes/route_name.dart';
import 'package:grocery_go/presentation/screens/account/account_screen.dart';
import 'package:grocery_go/presentation/screens/category_product/category_product_screen.dart';
import 'package:grocery_go/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:grocery_go/presentation/screens/favorite_screen/favorite_screen.dart';
import 'package:grocery_go/presentation/screens/login/login_screen.dart';
import 'package:grocery_go/presentation/screens/my_cart_screen/my_cart_screen.dart';
import 'package:grocery_go/presentation/screens/onboarding_screen/onboarding_screen.dart';
import 'package:grocery_go/presentation/screens/product_detail_screen/product_detail_screen.dart';
import 'package:grocery_go/presentation/screens/splash_screen/splash_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: RouteName.splash,
    routes: [
      GoRoute(
        path: RouteName.splash,
        name: RouteName.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteName.getStarted,
        name: RouteName.getStarted,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: RouteName.favorite,
        name: RouteName.favorite,
        builder: (context, state) => const FavoriteScreen(),
      ),
      GoRoute(
        path: RouteName.login,
        name: RouteName.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteName.dashboard,
        name: RouteName.dashboard,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: RouteName.account,
        name: RouteName.account,
        builder: (context, state) => const AccountScreen(),
      ),
      GoRoute(
        path: RouteName.cart,
        name: RouteName.cart,
        builder: (context, state) => const MyCartScreen(),
      ),
      GoRoute(
        path: RouteName.productDetail,
        name: RouteName.productDetail,
        builder: (context, state) =>
            ProductDetailScreen(productEntity: state.extra as ProductEntity),
      ),
      GoRoute(
        path: RouteName.categoryProduct,
        name: RouteName.categoryProduct,
        builder: (context, state) =>
            CategoryProductScreen(slug: state.extra as String),
      ),
    ],
  );
}
