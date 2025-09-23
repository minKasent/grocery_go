// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:grocery_go/presentation/theme/app_color_schemes.dart';
// import 'package:grocery_go/presentation/theme/app_typography.dart';
//
// import 'app_text.dart';
//
// class AppButton extends StatelessWidget {
//   final String title;
//   final VoidCallback? onTap;
//   final double? width;
//   const AppButton({super.key, required this.title, this.onTap, this.width});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 20),
//         width: width ?? (ScreenUtil().screenWidth - 60.w),
//         height: 67.h,
//         decoration: BoxDecoration(
//           color: AppColorSchemes.green,
//           borderRadius: BorderRadius.circular(19),
//         ),
//         child: AppText(content: title, style: AppTypography.text18w600),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_go/core/assets_gen/assets.gen.dart';
import 'package:grocery_go/core/enum/enum_button.dart';
import 'package:grocery_go/core/extensions/context_extention.dart';
import 'package:grocery_go/presentation/theme/app_color_schemes.dart';
import 'package:grocery_go/presentation/theme/app_typography.dart';

import 'app_text.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onTap;
  final ButtonState buttonState;
  final bool? leftIconPath;
  final String title;
  final double? width;
  final String subText;

  const AppButton({
    required this.title,
    this.leftIconPath,
    this.onTap,
    this.buttonState = ButtonState.normal,
    this.width = double.infinity,
    this.subText = '',
    super.key,
    required Color backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: _getBorderColor(context), width: 2),
                borderRadius: BorderRadius.circular(19),
                color: _getButtonColor(context),
              ),
              width: width ?? (ScreenUtil().screenWidth - 60.w),
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (leftIconPath != null) ...[
                    Image(image: Assets.icons.logoutIc.provider()),
                    SizedBox(width: 20.w),
                  ],
                  Expanded(
                    child: AppText(
                      content: title,
                      textAlign: TextAlign.center,
                      style: AppTypography.text18w600.copyWith(
                        color: _getTitleColor(context),
                      ),
                    ),
                  ),
                  if (leftIconPath != null) ...[SizedBox(width: 40.w)],
                ],
              ),
            ),
            if (subText.isNotEmpty)
              Positioned(
                top: 22.5.h,
                bottom: 22.5.h,
                right: 24.w,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColorSchemes.darkBlue,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  child: AppText(
                    content: subText,
                    textAlign: TextAlign.center,
                    style: AppTypography.text18w600.copyWith(
                      color: _getTitleColor(context),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getButtonColor(BuildContext context) {
    switch (buttonState) {
      case ButtonState.normal:
        return AppColorSchemes.green;
      case ButtonState.disable:
        return AppColorSchemes.white;
      case ButtonState.second:
        return context.theme.brightness == Brightness.dark
            ? AppColorSchemes.green
            : AppColorSchemes.darkGrey;
    }
  }

  Color _getTitleColor(BuildContext context) {
    switch (buttonState) {
      case ButtonState.normal:
        return AppColorSchemes.white;
      case ButtonState.disable:
        return AppColorSchemes.black;
      case ButtonState.second:
        return context.theme.brightness == Brightness.dark
            ? AppColorSchemes.white
            : AppColorSchemes.green;
    }
  }

  Color _getBorderColor(BuildContext context) {
    switch (buttonState) {
      case ButtonState.normal:
        return AppColorSchemes.green;
      case ButtonState.disable:
        return AppColorSchemes.white;
      case ButtonState.second:
        return AppColorSchemes.darkGrey;
    }
  }
}
