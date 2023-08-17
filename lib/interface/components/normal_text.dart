import 'package:flutter/material.dart';

class NormalText extends StatelessWidget {
  const NormalText({
    super.key,
    required this.text,
    this.size = 14,
    this.bold = false,
    this.color = Colors.white,
    this.textAlign,
    this.textOverflow,
  });

  final String text;
  final double size;
  final bool bold;
  final Color color;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: textOverflow,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: bold ? FontWeight.w600 : FontWeight.normal,
        letterSpacing: 0.3,
      ),
    );
  }
}
