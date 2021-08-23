import 'package:flutter/material.dart';

class Gender extends StatelessWidget {
  const Gender({
    Key? key,
    required this.isSelected,
    required this.index,
    required this.genderTitle,
  }) : super(key: key);

  final List<bool> isSelected;
  final int index;
  final String genderTitle;

  @override
  Widget build(BuildContext context) {
    // กล่องยาว 120 สูง 45 ขอบมนเฉพาะด้านบนซ้าย ล่างซ้าย ล่างขวา ด้านละ 30 สีพื้นหลังขึ้นอยู่กับค่าใน isSelected ลำดับที่ 0
    return Container(
      width: 120,
      height: 40,
      decoration: BoxDecoration(
        color: isSelected[index] ? Colors.green : Colors.green[200],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Center(
        child: Text(
          genderTitle,
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
