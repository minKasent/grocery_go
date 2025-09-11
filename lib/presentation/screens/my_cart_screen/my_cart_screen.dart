import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_go/core/assets_gen/assets.gen.dart';
import 'package:grocery_go/presentation/shared/app_button.dart';
import 'package:grocery_go/presentation/shared/app_text.dart';
import 'package:grocery_go/presentation/theme/app_color_schemes.dart';
import 'package:grocery_go/presentation/theme/app_typography.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Align(
              alignment: Alignment.center,
              child: AppText(
                content: "My Cart",
                style: AppTypography.text20w800,
              ),
            ),
            SizedBox(height: 20.h),
            Divider(
              color: AppColorSchemes.lightGrey,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
              child: Row(
                children: [
                  Image(image: Assets.images.sprite.provider()),
                  SizedBox(width: 40.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          content: "Sprite Can",
                          style: AppTypography.text16w400,
                        ),
                        AppText(
                          content: "1kg, Price",
                          style: AppTypography.text14w600,
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            _buildCounterButton(
                              Icons.remove,
                              onTap: () {
                                /// decrease item ,
                              },
                            ),
                            SizedBox(width: 15.w),
                            AppText(
                              content: "1",
                              style: AppTypography.text18w600.copyWith(
                                color: AppColorSchemes.black,
                              ),
                            ),
                            SizedBox(width: 15.w),
                            _buildCounterButton(
                              Icons.add,
                              onTap: () {
                                /// increase item
                              },
                              iconColor: AppColorSchemes.green,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          /// remove item
                        },
                        child: Icon(
                          Icons.close,
                          size: 25,
                          color: AppColorSchemes.grey,
                        ),
                      ),
                      SizedBox(height: 35.h),
                      AppText(
                        content: "\$4.99",
                        style: AppTypography.text18w600.copyWith(
                          color: AppColorSchemes.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            AppButton(
              title: "Go to Checkout",
              backgroundColor: AppColorSchemes.green,
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  GestureDetector _buildCounterButton(
    IconData icon, {
    VoidCallback? onTap,
    Color iconColor = Colors.black,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          border: Border.all(color: AppColorSchemes.lightGrey),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(icon, size: 25, color: iconColor),
      ),
    );
  }
}
