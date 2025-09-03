import 'package:flutter/material.dart';
import 'package:grocery_go/presentation/shared/app_text.dart';
import 'package:grocery_go/presentation/theme/app_color_schemes.dart';
class NumberScreen extends StatelessWidget {
  const NumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorSchemes.lightWhite,
      appBar: AppBar(
        actions: [
          // Image(image: Assets)
        ],
      ),
      body: Column(
        children: [
          AppText(content: "Enter your mobile number")
        ],
      ),
    );
  }
}
