import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizees/interface/colors/theme_colors.dart';
import 'package:quizees/interface/components/animated_sunrays.dart';
import 'package:quizees/interface/components/normal_text.dart';
import 'package:quizees/interface/components/space.dart';
import 'package:quizees/interface/pages/start_timer.dart';

import '../../model/topic_info.dart';

class Topic extends StatelessWidget {
  const Topic({super.key, required this.topic});

  final TopicInfo topic;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ThemeColors.primarySwatch.shade900,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            makeSunraysLayout(context: context, size: size),
            makeInfoLayout(context: context),
            makeButtonLayout(context: context),
          ],
        ),
      ),
    );
  }

  Widget makeSunraysLayout(
      {required BuildContext context, required Size size}) {
    return Expanded(
      flex: 2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedSunrays(height: size.width, width: size.width),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ThemeColors.primarySwatch.shade50,
            ),
            padding: EdgeInsets.all(size.width * 0.07),
            width: size.width * 0.3,
            height: size.width * 0.3,
            child: FittedBox(
              fit: BoxFit.contain,
              child: FaIcon(
                topic.iconData,
                color: ThemeColors.primarySwatch.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget makeInfoLayout({required BuildContext context}) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          NormalText(
            text: "Topic",
            color: ThemeColors.primarySwatch.shade200,
            size: 16,
            textAlign: TextAlign.center,
          ),
          NormalText(
            text: topic.label,
            size: 35,
            textAlign: TextAlign.center,
          ),
          const Space(vertical: 8),
          NormalText(
            text:
                "10 Questions will be there based on the topic.\nCorrect answer will be shown at the end of Quiz.\nStats will be given at the end of Quiz.\nAll the best!",
            color: ThemeColors.primarySwatch.shade200,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget makeButtonLayout({required BuildContext context}) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              borderRadius: BorderRadius.circular(16),
              splashFactory: InkSparkle.splashFactory,
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: ThemeColors.primarySwatch.shade50, width: 3),
                ),
                padding: const EdgeInsets.all(16),
                child: NormalText(
                  text: "Back",
                  color: ThemeColors.primarySwatch.shade50,
                ),
              ),
            ),
            const Space(horizontal: 16),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => const StartTimer()));
              },
              borderRadius: BorderRadius.circular(16),
              splashFactory: InkSparkle.splashFactory,
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: ThemeColors.primarySwatch.shade50,
                  border: Border.all(
                      color: ThemeColors.primarySwatch.shade50, width: 3),
                ),
                padding: const EdgeInsets.all(16),
                child: const NormalText(
                  text: "Start Quiz",
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
