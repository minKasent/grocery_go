import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_go/presentation/routes/route_name.dart';
import 'package:grocery_go/presentation/theme/app_color_schemes.dart';
import 'package:grocery_go/core/assets_gen/assets.gen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        context.go(RouteName.getStarted);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorSchemes.green,
      body: Center(
        child: Assets.images.splashScreenImg.image(
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
