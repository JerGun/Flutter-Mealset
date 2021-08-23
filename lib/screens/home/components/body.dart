import 'package:flutter/material.dart';
import 'package:flutter_mealset/models/meal.dart';
import 'package:flutter_mealset/screens/home/components/list_item.dart';

class Body extends StatelessWidget {
  // ชุดข้อมูลเพื่อทดสอบ
  final List meals = [
    Meal(
        title: 'ชุดทดลองที่ 1',
        foods: ['Fried rice', 'Hamburger'],
        calories: '2300'),
    Meal(
        title: 'ชุดทดลองที่ 2',
        foods: ['ข้าวมันไก่', 'ข้าวหมูแดง'],
        calories: '1500'),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        // สร้าง Listview
        child: ListView.builder(
      // สร้างตามจำนวนข้อมูลที่อยู่ใน List meals
      itemCount: meals.length,
      itemBuilder: (BuildContext context, int index) {
        // สร้าง List item ด้วยการเรียกใช้ ListItem
        return ListItem(
          title: meals[index].title,
          foods: meals[index].foods,
          calories: meals[index].calories,
        );
      },
    ));
  }
}