import 'package:flutter/material.dart';
import 'package:flutter_mealset/screens/add_meal/add_meal_screen.dart';
import 'package:flutter_mealset/screens/home/components/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // เรียกใช้ Body() เป็น body
      body: Body(),
      // ปุ่มเสริมด้านขวาล่าง พื้นหลังสีเขียว
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // นำทางไปยังหน้า AddMeal
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            // ขอบมนเฉพาะด้านบนซ้าย 80
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(80)),
            ),
            builder: (BuildContext context) => Container(
              child: AddMealScreen(),
            ),
          );
        },
        // ไอคอนรูปบวก สีดำ
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
