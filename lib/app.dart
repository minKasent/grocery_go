import 'package:chottu_link/chottu_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_go/l10n/app_localizations.dart';
import 'package:grocery_go/presentation/bloc/locale/locale_bloc.dart';
import 'package:grocery_go/presentation/bloc/locale/locale_state.dart';
import 'package:grocery_go/presentation/routes/app_router.dart';
import 'package:grocery_go/presentation/routes/route_name.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => LocaleBloc(), child: MyAppView());
  }

  // test
}

class MyAppView extends StatefulWidget {
  const MyAppView({super.key});

  @override
  State<MyAppView> createState() => _MyAppViewState();
}

class _MyAppViewState extends State<MyAppView> {
  @override
  void initState() {
    super.initState();
    _initializeDeepLinkHandling();
  }

  void _initializeDeepLinkHandling() {
    /// 🔗 Listen for incoming dynamic links
    /// This handles both cold start and warm start deep links
    ChottuLink.onLinkReceived.listen((String link) {
      debugPrint(" ✅ Link Received: $link");

      /// Add a small delay to ensure the app is fully initialized
      Future.delayed(const Duration(milliseconds: 500), () {
        _handleDeepLink(link);
      });
    });
  }

  void _handleDeepLink(String link) {
    try {
      /// Check if the widget is still mounted
      if (!mounted) {
        debugPrint(" ❌ Widget not mounted, skipping deep link: $link");
        return;
      }

      /// Tip: ➡️ Navigate to a specific page or take action based on the link
      /// Example: "https://onlinegrocerystore.chottu.link/product/2",
      if (link.contains("/product/")) {
        final productId = link.split("/product/")[1];
        final productIdInt = int.tryParse(productId);

        if (productIdInt != null) {
          /// Use GoRouter.router.go() instead of context.pushNamed()
          /// This works because we have access to the router instance directly
          AppRouter.router.goNamed(
            RouteName.productDetail,
            extra: {'productId': productIdInt, 'isFromDeepLink': true},
          );
          debugPrint(" ✅ Navigated to product detail with ID: $productIdInt");
        } else {
          debugPrint(" ❌ Invalid product ID: $productId");
        }
      } else {
        debugPrint(" ❌ Unsupported deep link format: $link");
      }
    } catch (e) {
      debugPrint(" ❌ Error handling deep link: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleBloc, LocaleState>(
      builder: (context, state) {
        return ScreenUtilInit(
          designSize: const Size(413, 896),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              ),
              routerConfig: AppRouter.router,
              locale: Locale(state.locale),
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [Locale('en'), Locale('vi')],
            );
          },
        );
      },
    );
  }
}
