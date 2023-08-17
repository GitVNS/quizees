import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizees/interface/colors/theme_colors.dart';
import 'package:quizees/interface/components/normal_text.dart';
import 'package:quizees/interface/components/painters.dart';
import 'package:quizees/interface/components/space.dart';
import 'package:quizees/interface/screens/stats.dart';
import 'package:quizees/interface/screens/profile.dart';

import '../../model/topic_info.dart';
import '../components/connect_with_friends.dart';
import '../pages/topic.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.primarySwatch.shade900,
      appBar: AppBar(
        elevation: 0,
        title: const Text("Quizees"),
        backgroundColor: ThemeColors.primarySwatch.shade900,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        children: [
          makeGreeting(context: context),
          const Space(vertical: 16),
          makeStatsButton(context: context),
          const Space(vertical: 16),
          makeTopicLayout(context: context),
          const Space(vertical: 16),
          makeCreateQuizButton(context: context),
          const Space(vertical: 16),
          ConnectWithFriends(onTap: () {}),
        ],
      ),
    );
  }

  Widget makeCreateQuizButton({required BuildContext context}) {
    return InkWell(
      onTap: () {},
      splashFactory: InkSparkle.splashFactory,
      borderRadius: BorderRadius.circular(8),
      child: Ink(
        height: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: [
              ThemeColors.primarySwatch.shade800,
              ThemeColors.primarySwatch.shade600,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const NormalText(text: "Create Quiz", size: 18),
                      NormalText(
                        text: "Create your own Quiz and share it with others",
                        color: ThemeColors.primarySwatch.shade100,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      painter: RingsBackgroundPainter(),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ThemeColors.primarySwatch.shade50,
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.plus,
                        color: ThemeColors.primarySwatch.shade700,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget makeTopicLayout({required BuildContext context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const NormalText(
          text: "Topics",
          size: 18,
        ),
        SizedBox(
          height: 130,
          width: double.infinity,
          child: ListView.separated(
            itemCount: topics.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(vertical: 8),
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => makeTopicsButton(
                context: context,
                label: topics[index].label,
                iconData: topics[index].iconData,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => Topic(
                                topic: topics[index],
                              )));
                }),
            separatorBuilder: (context, index) => const Space(horizontal: 8),
          ),
        ),
      ],
    );
  }

  Widget makeTopicsButton(
      {required BuildContext context,
      required String label,
      required IconData iconData,
      required VoidCallback onTap}) {
    return AspectRatio(
      aspectRatio: 1,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        splashFactory: InkSparkle.splashFactory,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ThemeColors.primarySwatch.shade50,
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: FaIcon(
                      iconData,
                      color: ThemeColors.primarySwatch.shade700,
                    ),
                  ),
                ),
              ),
              const Space(vertical: 8),
              NormalText(
                text: label,
                textOverflow: TextOverflow.ellipsis,
                color: ThemeColors.primarySwatch.shade700,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeStatsButton({required BuildContext context}) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (builder) => const Stats()));
      },
      borderRadius: BorderRadius.circular(8),
      splashFactory: InkSparkle.splashFactory,
      child: Ink(
        height: 110,
        decoration: BoxDecoration(
          color: ThemeColors.primarySwatch.shade800,
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: [
              ThemeColors.primarySwatch.shade800,
              ThemeColors.primarySwatch.shade600,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerLeft,
                  child: NormalText(
                    text: "Stats",
                    color: ThemeColors.primarySwatch.shade50,
                    size: 18,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: CustomPaint(
                  painter: BarChartDesignPainter(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeGreeting({required BuildContext context}) {
    return Container(
      height: 130,
      width: double.infinity,
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const NormalText(
                  text: "Welcome,",
                  size: 24,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  height: 20,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        "Outsmart the Rest - Quiz Now !",
                        textAlign: TextAlign.left,
                        speed: const Duration(milliseconds: 100),
                        textStyle: TextStyle(
                            color: ThemeColors.primarySwatch.shade50,
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis),
                      ),
                      TyperAnimatedText(
                        "Get in the Know - Quiz it Up !",
                        textAlign: TextAlign.left,
                        speed: const Duration(milliseconds: 100),
                        textStyle: TextStyle(
                            color: ThemeColors.primarySwatch.shade50,
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis),
                      ),
                      TyperAnimatedText(
                        "Quiz Time - Prove Your Smarts !",
                        textAlign: TextAlign.left,
                        speed: const Duration(milliseconds: 100),
                        textStyle: TextStyle(
                            color: ThemeColors.primarySwatch.shade50,
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis),
                      ),
                      TyperAnimatedText(
                        "Quiz Rush - Race to the Top !",
                        textAlign: TextAlign.left,
                        speed: const Duration(milliseconds: 100),
                        textStyle: TextStyle(
                            color: ThemeColors.primarySwatch.shade50,
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis),
                      ),
                      TyperAnimatedText(
                        "Quiz Craze - Test Your Knowledge !",
                        textAlign: TextAlign.left,
                        speed: const Duration(milliseconds: 100),
                        textStyle: TextStyle(
                            color: ThemeColors.primarySwatch.shade50,
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                    repeatForever: true,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => const Profile()));
              },
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: ThemeColors.primarySwatch.shade50, width: 3)),
                alignment: Alignment.center,
                child: Container(
                  width: 85,
                  height: 85,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ThemeColors.primarySwatch.shade50.withOpacity(0.4),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Icon(
                      Icons.person_4,
                      color: ThemeColors.primarySwatch.shade100,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
