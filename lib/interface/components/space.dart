import 'package:flutter/material.dart';

class Space extends StatelessWidget {
  const Space({
    super.key,
    this.vertical = 0,
    this.horizontal = 0,
  });
  final double vertical;
  final double horizontal;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: vertical,
      width: horizontal,
    );
  }
}
