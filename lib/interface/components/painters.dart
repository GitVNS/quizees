import 'dart:math';

import 'package:flutter/material.dart';

import '../colors/theme_colors.dart';

class StatsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    //to calculate graph layout size
    double availableLayoutForText = size.width * 0.8;
    double oneOfTenPartSize = availableLayoutForText / 10;

    drawGraphLines(
        canvas: canvas,
        size: size,
        oneOfTenPartSize: oneOfTenPartSize,
        availableLayoutForText: availableLayoutForText);
    drawXaxisLabelAndNumbers(
        canvas: canvas,
        size: size,
        oneOfTenPartSize: oneOfTenPartSize,
        availableLayoutForText: availableLayoutForText);
    drawMainAxisLines(canvas: canvas, size: size);

    for (double y = 0.15; y < 0.80; y += 0.15) {
      drawBar(
          canvas: canvas,
          yOffset: size.height * y,
          correctCount: Random().nextInt(10) + 2,
          oneOfTenPartSize: oneOfTenPartSize);
    }
  }

  drawMainAxisLines({required Canvas canvas, required Size size}) {
    Paint linePaint = Paint()
      ..color = ThemeColors.primarySwatch.shade100
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    //x-axis line
    canvas.drawLine(Offset(size.width * 0.05, size.height * 0.1),
        Offset(size.width * 0.95, size.height * 0.1), linePaint);

    //y-axis line
    canvas.drawLine(Offset(size.width * 0.1, size.height * 0.05),
        Offset(size.width * 0.1, size.height * 0.95), linePaint);
  }

  drawGraphLines({
    required Canvas canvas,
    required Size size,
    required double oneOfTenPartSize,
    required double availableLayoutForText,
  }) {
    double lineIncrementer = (oneOfTenPartSize * 2) + (oneOfTenPartSize / 2);
    for (double i = lineIncrementer - 4;
        i < availableLayoutForText + lineIncrementer - 8;
        i += oneOfTenPartSize) {
      canvas.drawLine(
        Offset(i, size.height * 0.07),
        Offset(i, size.height * 0.95),
        Paint()
          ..color = ThemeColors.primarySwatch.shade500
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  drawXaxisLabelAndNumbers({
    required Canvas canvas,
    required Size size,
    required double oneOfTenPartSize,
    required double availableLayoutForText,
  }) {
    //heading
    TextPainter textPainter = TextPainter(
      ellipsis: "..",
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "Correct Answers",
        style: TextStyle(
          fontFamily: "coolvetica",
          color: ThemeColors.primarySwatch.shade50,
          fontSize: 12,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: double.infinity,
    );
    textPainter.paint(canvas, Offset((oneOfTenPartSize * 5), 0));

    //numbers
    int numberToBePrint = 1;
    for (double i = oneOfTenPartSize * 2;
        i < availableLayoutForText + (oneOfTenPartSize * 2);
        i += oneOfTenPartSize) {
      TextPainter textPainter = TextPainter(
        ellipsis: "..",
        text: TextSpan(
          text: "$numberToBePrint",
          style: TextStyle(
            fontFamily: "coolvetica",
            color: ThemeColors.primarySwatch.shade50,
            fontSize: 12,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: oneOfTenPartSize,
      );
      textPainter.paint(canvas, Offset(i - 8, size.height * 0.05));
      numberToBePrint++;
    }
  }

  drawBar(
      {required Canvas canvas,
      required double yOffset,
      required int correctCount,
      required double oneOfTenPartSize}) {
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(oneOfTenPartSize + 8, yOffset,
                (oneOfTenPartSize * correctCount) + 4, oneOfTenPartSize),
            const Radius.circular(3)),
        Paint()
          ..color = ThemeColors.primarySwatch.shade50
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BarChartDesignPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = ThemeColors.primarySwatch.shade200
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
        colors: [
          ThemeColors.primarySwatch.shade100,
          ThemeColors.primarySwatch.shade400,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    List<double> heightFactorList = [.2, .3, .4, .5, .6, .7, .8];

    for (double x = 0; x < 1; x += 0.1) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            (size.width * x) + 0.02,
            size.height *
                heightFactorList[Random().nextInt(heightFactorList.length)],
            (size.width * 0.08),
            size.height + (size.height * 0.1),
          ),
          const Radius.circular(4),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class RingsBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    for (double radius = 20; radius < 200; radius += 20) {
      canvas.drawCircle(
        Offset(size.width / 2, size.height / 2),
        radius,
        Paint()
          ..color = ThemeColors.primarySwatch.shade200
              .withOpacity(1 - ((radius / 2) / 100))
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class RaysPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double totalRadius = size.width;
    double totalRays = 18;

    Paint paint = Paint()
      ..shader = RadialGradient(colors: [
        ThemeColors.primarySwatch.shade50.withOpacity(0.45),
        ThemeColors.primarySwatch.shade50.withOpacity(0),
      ]).createShader(Rect.fromCenter(
          center: center, width: size.width, height: size.height));

    double radius = (1 * pi) / totalRays;

    for (int i = 0; i < totalRays; i++) {
      canvas.drawPath(
          drawRay(totalRadius, radius * (i * 2), radius, size, center), paint);
    }
  }

  Path drawRay(double radiusArcShape, double d, double radius, Size size,
      Offset offset) {
    return Path()
      ..moveTo(offset.dx, offset.dy)
      ..arcTo(Rect.fromCircle(center: offset, radius: radiusArcShape), d,
          radius, false)
      ..close();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class HalftonePatternPainter extends CustomPainter {
  HalftonePatternPainter({required this.color});

  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    Paint whitePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    Paint midCirclePaint = Paint()
      ..color = color.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    for (double x = 0; x < 1 + 0.01; x += 0.05) {
      for (double y = 0; y < 1; y += 0.05) {
        canvas.drawCircle(
            Offset(size.width * x, size.height * y), (x * y) * 4, whitePaint);
      }
    }
    canvas.drawCircle(Offset(size.width, size.height), 4, midCirclePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
