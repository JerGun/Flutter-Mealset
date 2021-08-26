import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    Key? key,
    this.width = 80,
    required this.title,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.number,
  }) : super(key: key);

  final double width;
  final String title;
  final String hintText;
  final controller;
  final keyboardType;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ข้อความหัวข้อ
        Text(
          title,
          style: TextStyle(fontSize: 18),
        ),
        // กล่อง TextField ยาว 120 สูง 40
        Container(
          height: 40,
          width: width,
          child: TextField(
            // ปรับให้ Text อยู่ตรงกลางในแนวนอน
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              // ปรับให้ Text อยู่ตรงกลางในแนวตั้ง
              contentPadding: EdgeInsets.only(bottom: 20),
              hintText: hintText,
              // ปุ่มขอบมนเฉพาะด้านบนซ้าย ล่างซ้าย ล่างขวา ด้านละ 30 สีพื้นหลังสีเขียว
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: (Colors.green[200])!, width: 1.5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )),
              // ปุ่มเมื่อกดขอบมนเฉพาะด้านบนซ้าย ล่างซ้าย ล่างขวา ด้านละ 30 สีพื้นหลังสีเขียว
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green, width: 1.5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
            ),
            // ตั้งให้ Keyboard มีแค่ตัวเลข
            keyboardType: keyboardType,
            // สูงสุด 1 บรรทัด
            maxLines: 1,
            // Controller เพื่อให้ Widget อื่นดึงค่าหลังจากได้รับการ Input
            controller: controller,
          ),
        ),
      ],
    );
  }
}
