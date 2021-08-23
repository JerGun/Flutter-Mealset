import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem(
      {Key? key,
      required this.title,
      required this.foods,
      required this.calories})
      : super(key: key);

  final String title;
  final List<String> foods;
  final String calories;

  @override
  Widget build(BuildContext context) {
    // กล่องมีเงา ยาวสุดจอ ขอบมนทุกด้าน ด้านละ 10
    return Container(
      // ดันด้านนอกเฉพาะแนวตั้ง 10 แนวนอน 20
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ]),
      // ดันด้านในทุกด้าน ด้านละ 10
      child: Padding(
        padding: EdgeInsets.all(10),
        // Cloumn ข้างใน List item
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ข้อความหัวข้อ
            Text(
              title,
              style: TextStyle(fontSize: 18),
            ),
            // ตัด Widget มาต่อไว้ด้านล่างกรณีที่จำนวน Widget เกินขนาดของ List item
            Wrap(
              children: [
                // ลูปเพื่อดึงข้อมูลใน List มาแสดงในกล่อง
                for (var food in foods)
                  // กล่องขอบมนเฉพาะด้านบนซ้าย ล่างซ้าย ล่างขวา ด้านละ 30 สีพื้นหลังสีเขียว
                  Container(
                    // ดันด้านนอกเฉพาะด้านบน 5 ล่าง 5 ขวา 10
                    margin: EdgeInsets.only(top: 5, bottom: 5, right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        color: Colors.green[200]),
                    // ดันด้านในทุกด้าน
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(food),
                    ),
                  ),
                SizedBox(width: 10),
              ],
            ),
            // สร้างแถว
            Row(
              children: [
                // ข้อความหัวข้อ
                Text('แคลอรี่โดยประมาณ:'),
                // กล่องยาว 10
                SizedBox(width: 10),
                // กล่องขอบมนเฉพาะด้านบนซ้าย ล่างซ้าย ล่างขวา ด้านละ 30 สีพื้นหลังสีเขียว
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      color: Colors.green[200]),
                  // ดันด้านในทุกด้าน ด้านละ 6
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    // ข้อความเนื้อหา
                    child: Text('$calories แคลอรี่'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
