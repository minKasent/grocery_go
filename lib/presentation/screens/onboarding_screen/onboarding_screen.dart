import 'package:flutter/material.dart';
import 'package:grocery_go/core/assets_gen/assets.gen.dart';
import 'package:grocery_go/presentation/shared/app_button.dart';
import 'package:grocery_go/presentation/shared/app_text.dart';
import 'package:grocery_go/presentation/theme/app_color_schemes.dart';
import 'package:grocery_go/presentation/theme/app_typography.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: Assets.images.backgroundOnboardingImg.provider(),
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            left: 0,
            bottom: 70,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: Assets.images.logoImg.provider()),
                const SizedBox(height: 20),
                AppText(
                  content: "Welcome \n to our store",
                  style: AppTypography.text48w600,
                ),
                AppText(
                  content: "Ger your groceries in as fast as one hour",
                  style: AppTypography.text16w400,
                ),
                const SizedBox(height: 25,),
                AppButton(title: "Get Started",),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
