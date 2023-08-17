import 'package:flutter/material.dart';
import 'package:quizees/interface/colors/theme_colors.dart';
import 'package:quizees/interface/screens/dashboard.dart';

//https://dribbble.com/shots/17726071-Queezy-Leaderboard-Answers-Result-User-Profile

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "coolvetica",
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: ThemeColors.primarySwatch,
        ),
        brightness: Brightness.light,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: OpenUpwardsPageTransitionsBuilder()
          },
        ),
      ),
      home: const Dashboard(),
    );
  }
}
