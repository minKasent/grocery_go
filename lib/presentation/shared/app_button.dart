import 'package:flutter/material.dart';
import 'package:grocery_go/presentation/theme/app_color_schemes.dart';
import 'package:grocery_go/presentation/theme/app_typography.dart';

import 'app_text.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key});

  @override
  Container build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      width: 353, // implementation flutter_screenutil package
      height: 67,
      decoration: BoxDecoration(
        color: AppColorSchemes.green,
        borderRadius: BorderRadius.circular(19),
      ),
      child: AppText(content: "Get Started",style: AppTypography.text18w600,),
    );
  }
}
