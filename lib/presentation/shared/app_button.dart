import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_go/presentation/theme/app_color_schemes.dart';
import 'package:grocery_go/presentation/theme/app_typography.dart';

import 'app_text.dart';

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final double? width;
  const AppButton({super.key, required this.title, this.onTap, this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        width: width ?? (ScreenUtil().screenWidth - 60.w),
        height: 67.h,
        decoration: BoxDecoration(
          color: AppColorSchemes.green,
          borderRadius: BorderRadius.circular(19),
        ),
        child: AppText(content: title, style: AppTypography.text18w600),
      ),
    );
  }
}
