import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizees/interface/colors/theme_colors.dart';
import 'package:quizees/interface/components/normal_text.dart';
import 'package:quizees/interface/components/space.dart';
import 'package:quizees/interface/pages/quiz.dart';

class StartTimer extends StatefulWidget {
  const StartTimer({super.key});

  @override
  State<StartTimer> createState() => _StartTimerState();
}

class _StartTimerState extends State<StartTimer> {
  int maxSeconds = 5;
  int currentSeconds = 5;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    start();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void start() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (currentSeconds > 0) {
          currentSeconds--;
        } else {
          stop();
          HapticFeedback.heavyImpact();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (builder) => const Quiz()));
        }
      });
    });
  }

  void stop() {
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ThemeColors.primarySwatch.shade50,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: size.width * 0.5,
              width: size.width * 0.5,
              child: Stack(
                alignment: Alignment.center,
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 16,
                    value: currentSeconds / maxSeconds,
                    backgroundColor: ThemeColors.primarySwatch.shade100,
                    color: ThemeColors.primarySwatch,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: NormalText(
                      text: "$currentSeconds",
                      color: ThemeColors.primarySwatch,
                      size: size.width * 0.3,
                    ),
                  ),
                ],
              ),
            ),
            const Space(vertical: 32),
            const NormalText(
              text: "Get Ready",
              color: ThemeColors.primarySwatch,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
