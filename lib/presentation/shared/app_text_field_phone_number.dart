import 'package:flutter/material.dart';
import 'package:grocery_go/core/assets_gen/assets.gen.dart';

import 'app_text.dart';

class AppTextFieldPhoneNumber extends StatelessWidget {
  const AppTextFieldPhoneNumber({super.key});

  @override
  TextField build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(image: Assets.images.flag.provider()),
            const SizedBox(width: 10,),
            AppText(content: "+880"),
            const SizedBox(width: 10,),
          ],
        ),
      ),
      keyboardType: TextInputType.phone,
    );
  }
}
