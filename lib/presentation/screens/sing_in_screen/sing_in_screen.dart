import 'package:flutter/material.dart';
import 'package:grocery_go/core/assets_gen/assets.gen.dart';
import 'package:grocery_go/presentation/screens/sing_in_screen/widgets/app_button_singin_widget.dart';
import 'package:grocery_go/presentation/shared/app_text.dart';
import 'package:grocery_go/presentation/shared/app_text_field_phone_number.dart';
import 'package:grocery_go/presentation/theme/app_color_schemes.dart';
import 'package:grocery_go/presentation/theme/app_typography.dart';

class SingInScreen extends StatelessWidget {
  const SingInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorSchemes.lightWhite,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(image: Assets.images.backgroundSingin.provider()),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  content: "Get your groceries \n with nectar",
                  style: AppTypography.text26w600,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 20),
                AppTextFieldPhoneNumber(),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.center,
                  child: AppText(
                    content: "Or connect with social media",
                    style: AppTypography.text14w600,
                  ),
                ),
                const SizedBox(height: 30),
                AppButtonSinginWidget(isGoogle: true, onTap: () {}),
                const SizedBox(height: 20),
                AppButtonSinginWidget(isGoogle: false, onTap: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
