import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_go/presentation/shared/app_text.dart';
import 'package:grocery_go/presentation/theme/app_color_schemes.dart';
import 'package:grocery_go/presentation/theme/app_typography.dart';

class CommonDialogs {
  static bool isLoading = false;

  static void showLoadingDialog(BuildContext context) {
    if (isLoading) return;
    isLoading = true;
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 20),
                AppText(content: 'Loading', style: AppTypography.text16w400),
              ],
            ),
          ),
        );
      },
    ).then((_) {
      isLoading = false;
    });
  }

  static void hideLoadingDialog(BuildContext context) {
    if (!isLoading) return;
    context.pop();
  }

  static void showErrorDialog({
    required BuildContext context,
    String? title,
    String? message,
    VoidCallback? onTap,
  }) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColorSchemes.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
            side: BorderSide(color: AppColorSchemes.green),
          ),
          contentPadding: const EdgeInsets.all(16),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Warning icon
              Icon(Icons.warning),
              if (title != null) ...[
                const SizedBox(height: 8),

                // Title
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: AppColorSchemes.green,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              // Content
              Text(
                message ?? 'Something went wrong',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: AppColorSchemes.blue,
                ),
              ),
              const SizedBox(height: 32),
              // Buttons
              ElevatedButton(
                onPressed: () {
                  context.pop();
                  onTap?.call();
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColorSchemes.blue,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void showWarningDialog({
    required BuildContext context,
    required String message,
    String? cancelText,
    String? confirmText,
    VoidCallback? onCancel,
    VoidCallback? onConfirm,
    bool barrierDismissible = true,
    String? title,
  }) {
    showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColorSchemes.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: AppColorSchemes.lightWhite),
          ),
          contentPadding: const EdgeInsets.all(16),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Warning icon
              Icon(Icons.warning),
              if (title != null) ...[
                const SizedBox(height: 8),
                // Title
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: AppColorSchemes.blue,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              // Content
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: title != null ? 14 : 18,
                  color: title != null
                      ? AppColorSchemes.lightWhite
                      : AppColorSchemes.white,
                ),
              ),
              const SizedBox(height: 32),
              // Buttons
              Row(
                children: [
                  // Cancel button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.pop();
                        onCancel?.call();
                      },
                      child: Text(
                        cancelText ?? 'Cancel',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColorSchemes.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Confirm button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.pop();
                        onConfirm?.call();
                      },
                      child: Text(
                        confirmText ?? 'Confirm',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColorSchemes.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static void showToast({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 1),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        backgroundColor: AppColorSchemes.black,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
