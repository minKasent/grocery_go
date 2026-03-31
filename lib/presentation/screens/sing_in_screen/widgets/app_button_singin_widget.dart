import 'package:flutter/material.dart';
import 'package:grocery_go/core/assets_gen/assets.gen.dart';
import 'package:grocery_go/presentation/shared/app_text.dart';
import 'package:grocery_go/presentation/theme/app_color_schemes.dart';
import 'package:grocery_go/presentation/theme/app_typography.dart';

class AppButtonSinginWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isGoogle;
  const AppButtonSinginWidget({super.key, this.onTap, required this.isGoogle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 21, horizontal: 35),
      width: 364, // impl screenutil
      decoration: BoxDecoration(
        color: isGoogle ? AppColorSchemes.lightBlue : AppColorSchemes.blue,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Image(
            image: isGoogle
                ? Assets.icons.googleIc.provider()
                : Assets.icons.facebookIc.provider(),
          ),
          const SizedBox(width: 40),
          AppText(
            content: isGoogle
                ? "Continue with Google"
                : "Continue with Facebook",
            style: AppTypography.text18w600,
          ),
        ],
      ),
    );
  }
}
