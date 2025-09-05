import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CommonDialogs {
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  static void hideLoadingDialog(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    }
  }

  static void showAlertDialog(
    BuildContext context, {
    required String title,
    required String message,
    VoidCallback? onPressed,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                onPressed?.call();
                context.pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
