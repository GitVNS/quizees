import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizees/interface/components/painters.dart';
import 'package:quizees/interface/pages/quiz_result.dart';
import 'package:quizees/model/quiz_data.dart';

import '../colors/theme_colors.dart';
import '../components/normal_text.dart';
import '../components/space.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<QuizData> quizList = geographyQuiz;
  int currentQuestion = 0;
  List<int> correctAnswers = [];
  List<int> selectedOptions = [];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ThemeColors.primarySwatch.shade900,
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
                    size: size, question: quizList[currentQuestion].question),
              ],
            ),
            makeQuestionNumberLayout(),
            makeAnswerLayout(
              context: context,
              optionA: quizList[currentQuestion].optionA,
              optionB: quizList[currentQuestion].optionB,
              optionC: quizList[currentQuestion].optionC,
              optionD: quizList[currentQuestion].optionD,
            ),
          ],
        ),
      ),
    );
  }

  void checkAnswer({required int selectedOption}) {
    int answer = quizList[currentQuestion].answer;
    if (selectedOption == answer) {
      if (currentQuestion < 9) {
        setState(() {
          correctAnswers.add(currentQuestion);
          currentQuestion++;
        });
      } else {
        setState(() {
          correctAnswers.add(currentQuestion);
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (builder) => QuizResult(
                    correctAnswers: correctAnswers,
                    quiz: geographyQuiz,
                    selectedOptions: selectedOptions)));
      }
    } else {
      if (currentQuestion < 9) {
        setState(() {
          currentQuestion++;
        });
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (builder) => QuizResult(
                    correctAnswers: correctAnswers,
                    quiz: geographyQuiz,
                    selectedOptions: selectedOptions)));
      }
    }
  }

  Widget makeAnswerLayout({
    required BuildContext context,
    required String optionA,
    required String optionB,
    required String optionC,
    required String optionD,
  }) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            makeAnswerButton(
                onTap: () {
                  HapticFeedback.heavyImpact();
                  selectedOptions.add(1);
                  checkAnswer(selectedOption: 1);
                },
                answer: "1)  $optionA"),
            const Space(vertical: 16),
            makeAnswerButton(
                onTap: () {
                  HapticFeedback.heavyImpact();
                  selectedOptions.add(2);
                  checkAnswer(selectedOption: 2);
                },
                answer: "2)  $optionB"),
            const Space(vertical: 16),
            makeAnswerButton(
                onTap: () {
                  HapticFeedback.heavyImpact();
                  selectedOptions.add(3);
                  checkAnswer(selectedOption: 3);
                },
                answer: "3)  $optionC"),
            const Space(vertical: 16),
            makeAnswerButton(
                onTap: () {
                  HapticFeedback.heavyImpact();
                  selectedOptions.add(4);
                  checkAnswer(selectedOption: 4);
                },
                answer: "4)  $optionD"),
          ],
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
          color: ThemeColors.primarySwatch.shade50,
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

  Widget makeQuestionNumberLayout() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 8, color: Colors.black),
          color: ThemeColors.primarySwatch.shade50,
        ),
        child: NormalText(
          text: "${currentQuestion + 1}",
          color: Colors.black,
          bold: true,
          size: 18,
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
            size: 20,
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
          color: ThemeColors.primarySwatch.shade50,
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
                    painter: HalftonePatternPainter(
                      color: ThemeColors.primarySwatch.shade200,
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
