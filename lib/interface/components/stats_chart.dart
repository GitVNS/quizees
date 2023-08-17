import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../colors/theme_colors.dart';

class StatsChart extends StatelessWidget {
  const StatsChart({super.key, required this.count, this.isWeek = false});

  final int count;
  final bool isWeek;

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData(),
        titlesData: titlesData(),
        borderData: FlBorderData(show: false),
        barGroups: getData(),
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceEvenly,
        maxY: 11,
      ),
    );
  }

  BarTouchData barTouchData() {
    return BarTouchData(
      enabled: false,
      touchTooltipData: BarTouchTooltipData(
        tooltipBgColor: Colors.transparent,
        tooltipPadding: EdgeInsets.zero,
        tooltipMargin: 8,
        getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
        ) {
          return BarTooltipItem(
            rod.toY.round().toString(),
            TextStyle(
              color: ThemeColors.primarySwatch.shade50,
            ),
          );
        },
      ),
    );
  }

  FlTitlesData titlesData() {
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTitlesWidget: getBottomTitles,
        ),
      ),
      leftTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    );
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: ThemeColors.primarySwatch.shade50,
      fontSize: 14,
    );
    String label = isWeek ? "Day" : "Quiz";
    String text =
        count < 9 ? '$label ${value.toInt() + 1}' : "${value.toInt() + 1}";
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8,
      child: Text(text, style: style),
    );
  }

  LinearGradient getBarGradient({required int value}) {
    return LinearGradient(
      colors: value < 5
          ? [
              ThemeColors.red,
              ThemeColors.primarySwatch.shade50,
            ]
          : [
              ThemeColors.green,
              ThemeColors.primarySwatch.shade50,
            ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }

  List<BarChartGroupData> getData() {
    return List.generate(count, (index) {
      int barValue = Random().nextInt(10) + 1;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: barValue.toDouble(),
            gradient: getBarGradient(value: barValue),
            width: 30,
            borderRadius: BorderRadius.circular(3),
          )
        ],
        showingTooltipIndicators: [0],
      );
    });
  }
}
