import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizees/interface/colors/theme_colors.dart';
import 'package:quizees/interface/components/normal_text.dart';
import 'package:quizees/interface/components/space.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    );
  }

  toggleContainer() {
    if (_animation.status != AnimationStatus.completed) {
      _controller.forward();
    } else {
      _controller.animateBack(0, duration: const Duration(milliseconds: 100));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ThemeColors.primarySwatch.shade900,
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: ThemeColors.primarySwatch.shade900,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        children: [
          makeInfoLayout(size: size),
          const Space(vertical: 16),
          SizeTransition(
            sizeFactor: _animation,
            axis: Axis.vertical,
            child: const NormalText(
              text:
                  "Changing name feature is coming.. till then enjoy this animation :)",
              size: 20,
            ),
          ),
          const Space(vertical: 16),
          makeFriendshopRankLayout(context: context),
        ],
      ),
    );
  }

  Widget makeFriendshopRankLayout({required BuildContext context}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            ThemeColors.primarySwatch.shade800,
            ThemeColors.primarySwatch.shade700,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const NormalText(text: "Friendship Rank"),
          const Space(vertical: 8),
          Divider(color: ThemeColors.primarySwatch.shade400, thickness: 2),
          const Space(vertical: 8),
          makeRankingListTile(
            context: context,
            rank: 1,
            name: "Vinayak N. Shirke",
            points: 200,
          ),
          const Space(vertical: 8),
          Divider(color: ThemeColors.primarySwatch.shade400, thickness: 2),
          const Space(vertical: 8),
          Material(
            clipBehavior: Clip.antiAlias,
            color: Colors.transparent,
            child: InkWell(
              splashFactory: InkSparkle.splashFactory,
              onTap: () {},
              child: Ink(
                padding: const EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ThemeColors.primarySwatch.shade100,
                      ),
                      padding: const EdgeInsets.all(16),
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: FaIcon(
                          FontAwesomeIcons.peopleGroup,
                          color: ThemeColors.primarySwatch.shade700,
                        ),
                      ),
                    ),
                    const Space(horizontal: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const NormalText(
                              text: "Connect with Friends", size: 20),
                          const Space(vertical: 2),
                          NormalText(
                              text:
                                  "Play Quizees with your friends to see rankings",
                              color: ThemeColors.primarySwatch.shade200),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget makeRankingListTile(
      {required BuildContext context,
      required int rank,
      required String name,
      required int points}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ThemeColors.primarySwatch.shade400,
          ),
          padding: const EdgeInsets.all(8),
          child: NormalText(text: "$rank"),
        ),
        const Space(horizontal: 16),
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ThemeColors.primarySwatch.shade100,
          ),
          padding: const EdgeInsets.all(8),
          child: FittedBox(
            fit: BoxFit.cover,
            child: Icon(
              Icons.person_4,
              color: ThemeColors.primarySwatch.shade700,
            ),
          ),
        ),
        const Space(horizontal: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NormalText(text: name, size: 20),
              const Space(vertical: 2),
              NormalText(
                  text: "$points Points",
                  color: ThemeColors.primarySwatch.shade200),
            ],
          ),
        ),
      ],
    );
  }

  Widget makeInfoLayout({required Size size}) {
    return SizedBox(
      width: size.width,
      height: size.width * 0.9,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: (size.width * 0.3) / 2,
            left: 0,
            right: 0,
            bottom: 0,
            child: makeInfoContainer(size: size),
          ),
          Positioned(
            top: 0,
            child: makeProfilePhoto(size: size),
          ),
        ],
      ),
    );
  }

  Widget makeInfoContainer({required Size size}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ThemeColors.primarySwatch.shade50,
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(8, (size.width * 0.15) + 8, 8, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Center(
            child: NormalText(
              text: "Vinayak N. Shirke",
              size: 18,
              textAlign: TextAlign.center,
              color: ThemeColors.primarySwatch.shade900,
            ),
          ),
          const Space(vertical: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: ThemeColors.primarySwatch.shade700),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: makeSubInfoColumn(
                          iconData: FontAwesomeIcons.solidStar,
                          title: "Quiz Points",
                          information: "200"),
                    ),
                    VerticalDivider(
                      color: ThemeColors.primarySwatch.shade200,
                      thickness: 2,
                    ),
                    Expanded(
                      flex: 1,
                      child: makeSubInfoColumn(
                          iconData: FontAwesomeIcons.rankingStar,
                          title: "Friends Rank",
                          information: "N/A"),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Space(vertical: 8),
          Material(
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              splashFactory: InkSparkle.splashFactory,
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                toggleContainer();
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: ThemeColors.primarySwatch.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.pen,
                    color: ThemeColors.primarySwatch.shade700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget makeSubInfoColumn(
      {required IconData iconData,
      required String title,
      required String information}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FaIcon(
          iconData,
          color: ThemeColors.yellow,
        ),
        const Space(vertical: 8),
        NormalText(
          text: title,
          color: ThemeColors.primarySwatch.shade200,
        ),
        const Space(vertical: 3),
        NormalText(
          text: information,
          size: 18,
        ),
      ],
    );
  }

  Widget makeProfilePhoto({required Size size}) {
    return Container(
      height: size.width * 0.3,
      width: size.width * 0.3,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: ThemeColors.primarySwatch.shade100, width: 3),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(3),
      child: Container(
        width: size.width * 0.3,
        height: size.width * 0.3,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ThemeColors.primarySwatch.shade100,
        ),
        padding: const EdgeInsets.all(16),
        child: FittedBox(
          fit: BoxFit.cover,
          child: Icon(
            Icons.person_4,
            color: ThemeColors.primarySwatch.shade700,
          ),
        ),
      ),
    );
  }
}
