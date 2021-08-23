import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    Key? key,
    required this.title,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  final String title;
  final String hintText;
  final controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ข้อความหัวข้อ
        Text(
          title,
          style: TextStyle(fontSize: 18),
        ),
        Container(
          height: 40,
          width: 120,
          child: TextField(
            // ปรับให้ Text อยู่ตรงกลางในแนวนอน
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              // ปรับให้ Text อยู่ตรงกลางในแนวตั้ง
              contentPadding: EdgeInsets.only(bottom: 20),
              hintText: hintText,
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: (Colors.green[200])!, width: 1.5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green, width: 1.5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
            ),
            keyboardType: TextInputType.number,
            maxLines: 1,
            controller: controller,
          ),
        ),
      ],
    );
  }
}
