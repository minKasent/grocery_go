import 'dart:async';

import 'package:chottu_link/chottu_link.dart';
import 'package:flutter/cupertino.dart';
import 'package:grocery_go/app.dart';
import 'package:grocery_go/di/env_module.dart';
import 'package:grocery_go/di/injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// ✅ Initialize the ChottuLink SDK with retry mechanism
  /// Make sure to call this before using any ChottuLink features.
  bool chottuLinkInitialized = false;
  int retryCount = 0;
  const int maxRetries = 3;

  while (!chottuLinkInitialized && retryCount < maxRetries) {
    try {
      debugPrint(
        "🔄 Attempting to initialize ChottuLink (attempt ${retryCount + 1}/$maxRetries)...",
      );

      // Add timeout wrapper to prevent indefinite waiting
      await ChottuLink.init(
        apiKey: "c_api_FJpMEvPLuTfCeWdxQWOrVNaXhx2uIZn4",
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException(
            'ChottuLink initialization timed out after 10 seconds',
            const Duration(seconds: 10),
          );
        },
      );

      chottuLinkInitialized = true;
      debugPrint("✅ ChottuLink initialized successfully");
    } catch (e) {
      retryCount++;
      debugPrint(
        "❌ ChottuLink initialization failed (attempt $retryCount/$maxRetries): $e",
      );

      if (retryCount < maxRetries) {
        debugPrint("⏳ Waiting 2 seconds before retry...");
        await Future.delayed(const Duration(seconds: 2));
      } else {
        debugPrint(
          "❌ ChottuLink initialization failed after $maxRetries attempts. Dynamic links will not work.",
        );
      }
    }
  }
  await configureDependencies(env: dev.name);

  runApp(const MyApp());
}
