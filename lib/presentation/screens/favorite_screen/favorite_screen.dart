import 'package:flutter/material.dart';
import 'package:grocery_go/core/assets_gen/assets.gen.dart';
import 'package:grocery_go/presentation/shared/app_button.dart';
import 'package:grocery_go/presentation/shared/app_text.dart';
import 'package:grocery_go/presentation/theme/app_color_schemes.dart';
import 'package:grocery_go/presentation/theme/app_typography.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          content: "Favorite",
          style: AppTypography.text16w400.copyWith(
            fontSize: 20,
            color: AppColorSchemes.black,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0.7),
          child: Divider(
            height: 0.7,
            thickness: 0.5,
            color: AppColorSchemes.grey,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image(image: Assets.images.sprite.provider()),
                const SizedBox(width: 40),
                Column(
                  children: [
                    AppText(
                      content: "Sprite Can",
                      style: AppTypography.text16w400,
                    ),
                    AppText(
                      content: "325ml, Price",
                      style: AppTypography.text14w600,
                    ),
                  ],
                ),
                const Spacer(),
                AppText(content: "\$1.50", style: AppTypography.text16w400),
                const SizedBox(width: 20),
                Icon(Icons.navigate_next),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: AppButton(title: "Add All To Cart"),
          ),
        ],
      ),
    );
  }
}
