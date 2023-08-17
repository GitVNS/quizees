import 'package:flutter/material.dart';
import 'package:quizees/interface/components/painters.dart';

class AnimatedSunrays extends StatefulWidget {
  const AnimatedSunrays({super.key, required this.height, required this.width});

  final double height;
  final double width;

  @override
  State<AnimatedSunrays> createState() => _AnimatedSunraysState();
}

class _AnimatedSunraysState extends State<AnimatedSunrays>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> rotate;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 40));
    rotate = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: rotate,
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: CustomPaint(
          painter: RaysPainter(),
        ),
      ),
    );
  }
}
