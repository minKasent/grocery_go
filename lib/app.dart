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

    /// 🔗 Listen for incoming dynamic links
    ChottuLink.onLinkReceived.listen((String link) {
      debugPrint(" ✅ Link Received: $link");
      //  "https://onlinegroceries.chottu.link/product/${widget.productId}",

      if (!mounted) {
        return;
      }

      try {
        if (link.contains('/product/')) {
          final productId = link.split("/product/")[1];
          final productIdInt = int.parse(productId);
          context.go(
            RouteName.productDetail,
            extra: {'productId': productIdInt, 'isFromDeepLink': true},
          );
        }
      } catch (e) {
        debugPrint("❌ Error parsing link: $e");
      }

      /// Tip: ➡️ Navigate to a specific page or take action based on the link
    });
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
