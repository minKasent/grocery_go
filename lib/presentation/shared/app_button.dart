import 'package:flutter/material.dart';
import 'package:grocery_go/presentation/theme/app_color_schemes.dart';
import 'package:grocery_go/presentation/theme/app_typography.dart';

import 'app_text.dart';

class AppButton extends StatelessWidget {
  final String title;
  const AppButton({super.key, required this.title});

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
      child: AppText(content: title,style: AppTypography.text18w600,),
    );
  }
}
