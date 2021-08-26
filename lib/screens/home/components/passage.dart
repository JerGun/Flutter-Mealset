import 'package:flutter/material.dart';

class Passage extends StatelessWidget {
  const Passage({
    Key? key,
    required this.passage,
    this.color = Colors.white,
  }) : super(key: key);

  final String passage;
  final color;

  @override
  Widget build(BuildContext context) {
    return Text(
      passage,
      style: TextStyle(
        color: color,
        fontSize: 50,
        // ตัวหนา
        fontWeight: FontWeight.bold,
        // เพิ่มเงา
        shadows: [
          Shadow(
            offset: Offset(1, 5),
            blurRadius: 3,
            color: Colors.black.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
