import 'package:flutter/material.dart';
import 'package:grocery_go/presentation/screens/number_screen/number_screen.dart';
import 'package:grocery_go/presentation/screens/sing_in_screen/sing_in_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: NumberScreen(),
    );
  }
}
