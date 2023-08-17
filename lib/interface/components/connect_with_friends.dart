import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizees/interface/components/space.dart';

import '../colors/theme_colors.dart';
import 'normal_text.dart';

class ConnectWithFriends extends StatelessWidget {
  const ConnectWithFriends({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      splashFactory: InkSparkle.splashFactory,
      child: Ink(
        decoration: BoxDecoration(
            color: ThemeColors.primarySwatch.shade700,
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Space(vertical: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ThemeColors.primarySwatch.shade400),
                  child: Icon(
                    Icons.public,
                    color: ThemeColors.primarySwatch.shade50,
                  ),
                ),
                const Space(horizontal: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const NormalText(text: "Connect", size: 18),
                      NormalText(
                        text: "Connect With Your Friends",
                        color: ThemeColors.primarySwatch.shade200,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Space(vertical: 16),
            Container(
              width: double.infinity,
              height: 100,
              decoration: const BoxDecoration(
                color: ThemeColors.yellow,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: const FittedBox(
                fit: BoxFit.contain,
                child: FaIcon(
                  FontAwesomeIcons.peopleGroup,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
