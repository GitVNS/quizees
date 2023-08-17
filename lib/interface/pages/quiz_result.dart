import 'package:flutter/material.dart';
import 'package:quizees/interface/colors/theme_colors.dart';
import 'package:quizees/interface/components/normal_text.dart';
import 'package:quizees/interface/components/space.dart';
import 'package:quizees/model/quiz_data.dart';

class QuizResult extends StatelessWidget {
  const QuizResult({
    super.key,
    required this.quiz,
    required this.correctAnswers,
    required this.selectedOptions,
  });
  final List<QuizData> quiz;
  final List<int> correctAnswers;
  final List<int> selectedOptions;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ThemeColors.primarySwatch.shade900,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(0),
          children: [
            makeScorePresenter(size: size),
            ListView.separated(
              shrinkWrap: true,
              itemCount: quiz.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return makeQuizPreiewLayout(index: index);
              },
              separatorBuilder: (context, index) {
                return const Space(vertical: 8);
              },
            ),
            makeDoneButton(context: context),
          ],
        ),
      ),
    );
  }

  Widget makeQuizPreiewLayout({required int index}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: correctAnswers.contains(index)
              ? ThemeColors.darkGreen
              : ThemeColors.darkRed),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          NormalText(text: "Q.${index + 1}) ${quiz[index].question}"),
          const Space(vertical: 8),
          NormalText(
            text: "1) ${quiz[index].optionA}",
            color: selectedOptions[index] == 1
                ? ThemeColors.primarySwatch.shade50
                : ThemeColors.primarySwatch.shade50.withOpacity(0.5),
          ),
          NormalText(
            text: "2) ${quiz[index].optionB}",
            color: selectedOptions[index] == 2
                ? ThemeColors.primarySwatch.shade50
                : ThemeColors.primarySwatch.shade50.withOpacity(0.5),
          ),
          NormalText(
            text: "3) ${quiz[index].optionC}",
            color: selectedOptions[index] == 3
                ? ThemeColors.primarySwatch.shade50
                : ThemeColors.primarySwatch.shade50.withOpacity(0.5),
          ),
          NormalText(
            text: "4) ${quiz[index].optionD}",
            color: selectedOptions[index] == 4
                ? ThemeColors.primarySwatch.shade50
                : ThemeColors.primarySwatch.shade50.withOpacity(0.5),
          ),
          if (!correctAnswers.contains(index))
            makeCorrectAnswerLayout(index: index),
        ],
      ),
    );
  }

  Widget makeScorePresenter({required Size size}) {
    return SizedBox(
      height: size.width,
      width: size.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: size.width * 0.6,
            height: size.width * 0.6,
            child: CircularProgressIndicator(
              strokeWidth: 16,
              value: correctAnswers.length / 10,
              backgroundColor: ThemeColors.primarySwatch.shade100,
              color: ThemeColors.primarySwatch,
            ),
          ),
          NormalText(
            text: "Score - ${correctAnswers.length}",
            size: 30,
          ),
        ],
      ),
    );
  }

  Widget makeCorrectAnswerLayout({required int index}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Divider(color: ThemeColors.primarySwatch.shade50),
        NormalText(text: "Correct Answer - ${quiz[index].answer}"),
      ],
    );
  }

  Widget makeDoneButton({required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        splashFactory: InkSparkle.splashFactory,
        borderRadius: BorderRadius.circular(8),
        child: Ink(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: ThemeColors.primarySwatch.shade100),
          height: 50,
          width: double.infinity,
          child: Center(
            child: NormalText(
              text: "Done",
              color: ThemeColors.primarySwatch.shade700,
            ),
          ),
        ),
      ),
    );
  }
}
