import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.title,
    required this.foods,
    required this.calories,
    required this.delete,
    required this.color,  }) : super(key: key);

  final title;
  final foods;
  final calories;
  final delete;
  final color;

  @override
  Widget build(BuildContext context) {
    return Container(
      // ดันด้านนอกเฉพาะแนวตั้ง 10 แนวนอน 20
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 10),
      // ซ้อน Widget
      child: Stack(
        children: [
          Container(
            // ดันด้านนอกเฉพาะด้านขวา 33
            margin: EdgeInsets.only(right: 33),
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
              ],
            ),
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
                          // ดันด้านในทุกด้าน ด้านละ 8
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
                        // ดันด้านนอกเฉพาะด้านบนและด้านล่าง ด้านละ 5
                        margin: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                            color: color),
                        // ดันด้านในทุกด้าน ด้านละ 8
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
          ),
          // กำหนดตำแหน่ง
          Positioned.fill(
            // กำหนดให้อยู่ตรงกลางด้านขวา
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: delete,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 0,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
                style: ButtonStyle(splashFactory: NoSplash.splashFactory),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
