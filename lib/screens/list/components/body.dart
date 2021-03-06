import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_mealset/models/meal.dart';
import 'package:flutter_mealset/screens/list/components/list_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late String title;
  late double tdee;
  late List<String> foods;
  late String calories;

  List meals = [
    // ชุดข้อมูลเพื่อทดสอบ
    Meal(
        title: 'ชุดทดลองที่ 1',
        foods: ['Fried rice', 'Hamburger'],
        calories: '2300',
        tdee: 1500),
    Meal(
        title: 'ชุดทดลองที่ 2',
        foods: ['ข้าวมันไก่', 'ข้าวหมูแดง'],
        calories: '1600',
        tdee: 1500),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        // ดันด้านนอกเฉพาะด้านบน 10
        margin: EdgeInsets.only(top: 10),
        // สร้างการ Refresh
        child: RefreshIndicator(
          onRefresh: () {
            // ดีเลย์ 0.5 วินาทีเพื่อจำลองการดึงข้อมูล
            return Future.delayed(Duration(milliseconds: 500), refreshData);
          },
          // กำหนดเงื่อนไขในการสร้าง child กำหนดตาม meals.length
          child: (meals.length != 0)
              // สร้าง Listview
              ? ListView.builder(
                  // สร้างตามจำนวนข้อมูลที่อยู่ใน List meals
                  itemCount: meals.length,
                  itemBuilder: (BuildContext context, int index) {
                    // สร้าง ListItem
                    return ListItem(
                      title: meals[index].title,
                      foods: meals[index].foods,
                      calories: meals[index].calories,
                      delete: () {
                        deleteListItem(index, meals[index].title);
                      },
                      // เปลี่ยนสีตามเงื่อนไข ถ้าค่าสัมบูรณ์ของ TDEE - Calories ของอาหารที่สุ่มมาแล้วได้ ไม่เกิน 500
                      color: ((meals[index].tdee -
                                      double.parse(meals[index].calories))
                                  .abs() <=
                              500)
                          ? Colors.green[200]
                          : Colors.red[200],
                    );
                  },
                )
              // สร้าง LayoutBuilder เพื่อใช้ constraints ในการทำให้ ListItem สูงตาม constraints
              : LayoutBuilder(
                  builder: (context, constraints) => ListView(
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          // กำหนดความสูงให้ ListItem อันแรกทีเป็น Container ให้สูงที่สุด
                          minHeight: constraints.maxHeight,
                        ),
                        // กำหนดข้อความอยู่ตรงกลาง ListItem
                        child: Center(
                          child: Text(
                            'ยังไม่มีชุดอาหาร \n กดปุ่ม "เพิ่ม" เพื่อสร้างชุดอาหาร',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  // ฟังก์ชันในการลบ ListItem
  deleteListItem(int index, String title) {
    // เปิด Dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ลบรายการ'),
          content: Text('ต้องการลบรายการชื่อ $title ใช่หรือไม่?'),
          actions: [
            // สร้างปุ่มเพื่อยกเลิกการลบ
            TextButton(
              onPressed: () {
                // ปิด AlertDialog
                Navigator.pop(context);
              },
              child: Text(
                'ไม่',
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
            // สร้างปุ่มเพื่อยืนยันการลบ
            TextButton(
              onPressed: () async {
                // ลบข้อมูลออกจาก List meals ณ ตำแหน่ง index
                setState(() {
                  meals.removeAt(index);
                });
                // ออกจาก Dialog
                Navigator.pop(context);
              },
              child: Text(
                'ใช่',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  // ฟังก์ชันในการ refresh ListView โดยการตรวจสอบว่า prefs มีการเก็บข้อมูลไว้หรือไม่ถ้ามีให้เพิ่มข้อมูลเข้าไปใน List meals
  FutureOr<void> refreshData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // อ่าน Data ที่เก็บไว้
      title = prefs.getString('title') ?? '';
      calories = prefs.getString('calories') ?? '0';
      foods = prefs.getStringList('foods') ?? <String>[];
      tdee = prefs.getDouble('tdee') ?? 0;

      // ตรวจสอบความยาว foods เพื่อเพิ่ม Meal ใน list meals
      if (foods.length != 0)
        meals.add(
          Meal(title: title, foods: foods, calories: calories, tdee: tdee),
        );

      // ลบ Data ที่เก็บไว้
      prefs.remove('title');
      prefs.remove('calories');
      prefs.remove('foods');
      prefs.remove('tdee');
    });
  }
}
