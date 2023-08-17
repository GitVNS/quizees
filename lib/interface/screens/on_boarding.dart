import 'package:flutter/material.dart';
import 'package:quizees/interface/colors/theme_colors.dart';
import 'package:quizees/interface/components/normal_text.dart';
import 'package:quizees/interface/components/space.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  /////////TIMEPASS PAGE

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                makeHalftoneBackground(size: size),
                makeQuestionBoxBackground(size: size),
                makeQuestionBox(
                    size: size, question: "Who was India's first President?"),
              ],
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    makeAnswerButton(
                        onTap: () {}, answer: "1)  Dr. APJ Abdul Kalaam"),
                    const Space(vertical: 16),
                    makeAnswerButton(
                        onTap: () {}, answer: "2)  Subhash Chandra Bose"),
                    const Space(vertical: 16),
                    makeAnswerButton(
                        onTap: () {}, answer: "3)  Jawaharlaal Nehru"),
                    const Space(vertical: 16),
                    makeAnswerButton(onTap: () {}, answer: "4)  Indira Gandhi"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget makeQuestionBox({required Size size, required String question}) {
    return Transform(
      transform: Matrix4.skewY(-0.1),
      child: Transform.translate(
        offset: const Offset(-5, 5),
        child: Container(
          height: size.width * 0.6,
          width: size.width * 0.75,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(width: 8, color: Colors.black),
          ),
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: NormalText(
            text: question,
            color: Colors.black,
            size: 24,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget makeQuestionBoxBackground({required Size size}) {
    return Transform(
      transform: Matrix4.skewY(-0.08),
      child: Container(
        height: size.width * 0.6,
        width: size.width * 0.75,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
        ),
      ),
    );
  }

  Widget makeHalftoneBackground({required Size size}) {
    int giveRotation(int index) {
      switch (index) {
        case 0:
          return 0;
        case 1:
          return 1;
        case 2:
          return 3;
        case 3:
          return 2;
        default:
          return 0;
      }
    }

    return Transform.rotate(
      angle: 20,
      child: Transform.scale(
        scale: 1.5,
        child: SizedBox(
          height: size.width,
          width: size.width,
          child: GridView.builder(
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
              ),
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return RotatedBox(
                  quarterTurns: giveRotation(index),
                  child: CustomPaint(
                    painter:
                        FadingPattern(color: Colors.white.withOpacity(0.6)),
                  ),
                );
              }),
        ),
      ),
    );
  }

  Widget makeAnswerButton(
      {required VoidCallback onTap, required String answer}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      splashFactory: InkSparkle.splashFactory,
      child: Ink(
        height: 60,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: ThemeColors.primarySwatch.shade800,
              blurRadius: 10,
              offset: const Offset(5, 5),
            ),
          ],
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: NormalText(
            text: answer,
            color: Colors.black,
            size: 16,
          ),
        ),
      ),
    );
  }
}

class FadingPattern extends CustomPainter {
  FadingPattern({required this.color});

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

    // for (double x = 0; x < size.width; x += size.width / 24) {
    //   Path path = Path()
    //     ..moveTo(x, x)
    //     ..lineTo(size.width - x, x)
    //     ..lineTo(size.width - x, size.height - x)
    //     ..lineTo(x, size.height - x)
    //     ..lineTo(x, x);

    //   // double distance = 0.0;

    //   // for (PathMetric pathMetric in path.computeMetrics()) {
    //   //   while (distance < pathMetric.length) {
    //   //     path = pathMetric.extractPath(distance, distance + 10)
    //   //       ..addOval(
    //   //           Rect.fromCenter(center: Offset.zero, width: 10, height: 10));
    //   //     distance += 10;
    //   //     distance += 24;
    //   //   }
    //   // }
    //   canvas.drawPath(
    //     path,
    //     Paint()
    //       ..color = bgColor
    //       ..style = PaintingStyle.stroke
    //       ..strokeWidth = 2,
    //   );
    // }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
