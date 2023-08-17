import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quizees/interface/colors/theme_colors.dart';
import 'package:quizees/interface/components/normal_text.dart';
import 'package:quizees/interface/components/stats_chart.dart';

class Stats extends StatefulWidget {
  const Stats({super.key});

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: ThemeColors.primarySwatch.shade900,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ThemeColors.primarySwatch.shade900,
          title: const Text("Stats"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            makeTabBar(),
            makeTabBarView(),
          ],
        ),
      ),
    );
  }

  Widget makeTabBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.black26,
      ),
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: TabBar(
        padding: const EdgeInsets.all(3),
        indicator: BoxDecoration(
          color: ThemeColors.primarySwatch.shade700,
          borderRadius: BorderRadius.circular(4),
        ),
        splashFactory: InkSparkle.splashFactory,
        splashBorderRadius: BorderRadius.circular(4),
        tabs: const [
          Tab(text: "Today"),
          Tab(text: "Weekly"),
          Tab(text: "Monthly"),
        ],
      ),
    );
  }

  Widget makeTabBarView() {
    return Expanded(
      child: TabBarView(
        physics: const BouncingScrollPhysics(),
        children: [
          makeTodayStatsLayout(),
          makeWeeklyStatsLayout(),
          makeMonthlyStatsLayout(),
        ],
      ),
    );
  }

  Widget makeTodayStatsLayout() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        Container(
          height: 300,
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ThemeColors.primarySwatch.shade700,
          ),
          child: const StatsChart(count: 6),
        ),
      ],
    );
  }

  Widget makeWeeklyStatsLayout() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: List.generate(
        7,
        (index) => Container(
          margin: const EdgeInsets.only(bottom: 16),
          height: 300,
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ThemeColors.primarySwatch.shade700,
          ),
          child: Column(
            children: [
              Expanded(child: StatsChart(count: (Random().nextInt(8) + 3))),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: NormalText(text: "Day ${index + 1}"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeMonthlyStatsLayout() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: List.generate(
        4,
        (index) => Container(
          margin: const EdgeInsets.only(bottom: 16),
          height: 300,
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ThemeColors.primarySwatch.shade700,
          ),
          child: Column(
            children: [
              const Expanded(child: StatsChart(count: 7, isWeek: true)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: NormalText(text: "Week ${index + 1}"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
