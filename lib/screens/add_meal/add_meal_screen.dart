import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_mealset/screens/add_meal/components/gender.dart';
import 'package:flutter_mealset/screens/add_meal/components/text_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMealScreen extends StatefulWidget {
  AddMealScreen({Key? key}) : super(key: key);

  @override
  _AddMealScreenState createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  List<bool> isSelected = [true, false];
  List<String> activity = <String>[
    'ไม่ออกกำลังกาย',
    '1 - 3 วัน/สัปดาห์',
    '3 - 5 วัน/สัปดาห์',
    '6 - 7 วัน/สัปดาห์',
    'ออกกำลังกายทุกวันเช้าเย็น'
  ];
  String dropdownValue = 'ไม่ออกกำลังกาย';
  bool isEmpty = false;

  double tdee = 0;

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final ageController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  late List foods;

  // อ่าน jsonfile แล้วเก็บค่าไว้ใน foods
  Future readJsonData() async {
    final jsondata = await rootBundle.loadString('assets/data/food.json');
    setState(() {
      foods = json.decode(jsondata);
    });
  }

  // เรียกใช้ฟังก์ชันเมื่อเริ่มต้น
  @override
  void initState() {
    super.initState();
    this.readJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // กำหนดให้ขนาดแนวตั้งเท่ากับ min
      mainAxisSize: MainAxisSize.min,
      children: [
        // กล่องดันด้านนอกเฉพาะด้านบน 20 ด้านล่าง 10
        Container(
          margin: EdgeInsets.only(top: 20, bottom: 10),
          child: Row(
            // ตั้งให้ตรงกลางแถว
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.local_dining, color: Colors.green, size: 42),
              SizedBox(width: 10),
              Text(
                'สุ่มชุดอาหาร',
                style: TextStyle(fontSize: 22),
              ),
            ],
          ),
        ),
        // เส้น Divider ยาว 80% ของหน้าจอ ความหนา 1
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Divider(
            thickness: 1,
          ),
        ),
        // กล่องดันด้านนอกเฉพาะด้านซ้าย 40
        Container(
          margin: EdgeInsets.only(left: 40),
          child: Column(
            // กำหนดให้ Widget ชิดซ้าย
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              // สร้างกล่องข้อความโดยเรียกใช้ class TextInput และส่ง parameters width title hinText และ controller ไปยัง class
              TextInput(
                width: 200,
                title: 'ชื่อชุดอาหาร: ',
                hintText: 'ชุดทดลอง',
                controller: titleController,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 20),
              // สร้างกล่องข้อความโดยเรียกใช้ class TextInput และส่ง parameters width title hinText และ controller ไปยัง class
              TextInput(
                title: 'จำนวนมื้ออาหาร: ',
                hintText: '5',
                controller: amountController,
              ),
              SizedBox(height: 20),
              // สร้างแถว
              Row(
                // Children Widget จะชิดซ้ายทั้งหมด
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // ข้อความหัวข้อ
                  Text(
                    'เพศ: ',
                    style: TextStyle(fontSize: 18),
                  ),
                  // กล่องขอบมนเฉพาะด้านบนซ้าย ล่างซ้าย ล่างขวา ด้านละ 30 สีพื้นหลังสีเขียว
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        color: Colors.green[200]),
                    child: Row(
                      children: [
                        // ตรวจจับการทำงาน onTap
                        GestureDetector(
                          onTap: () {
                            // set ค่าให้ isSelected
                            setState(() {
                              isSelected = [true, false];
                            });
                          },
                          // เรียกใช้ Gender เป็น child โดยส่ง parameters isSelected index และ genderTitle
                          child: Gender(
                            isSelected: isSelected,
                            index: 0,
                            genderTitle: 'ชาย',
                          ),
                        ),
                        // ตรวจจับการทำงาน onTap
                        GestureDetector(
                          onTap: () {
                            // set ค่าให้ isSelected
                            setState(() {
                              isSelected = [false, true];
                            });
                          },
                          // เรียกใช้ Gender เป็น child โดยส่ง parameters isSelected index และ genderTitle
                          child: Gender(
                            isSelected: isSelected,
                            index: 1,
                            genderTitle: 'หญิง',
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              // สร้างกล่องข้อความโดยเรียกใช้ class TextInput และส่ง parameters title hinText และ controller ไปยัง class
              TextInput(
                title: 'ส่วนสูง (เซนติเมตร): ',
                hintText: '175',
                controller: heightController,
              ),
              SizedBox(height: 20),
              // สร้างกล่องข้อความโดยเรียกใช้ class TextInput และส่ง parameters title hinText และ controller ไปยัง class
              TextInput(
                title: 'น้ำหนัก (กิโลกรัม): ',
                hintText: '70',
                controller: weightController,
              ),
              SizedBox(height: 20),
              // สร้างกล่องข้อความโดยเรียกใช้ class TextInput และส่ง parameters title hinText และ controller ไปยัง class
              TextInput(
                title: 'อายุ (ปี): ',
                hintText: '23',
                controller: ageController,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  // ข้อความหัวข้อ
                  Text(
                    'กิจกรรม: ',
                    style: TextStyle(fontSize: 18),
                  ),
                  // กล่องขอบมนเฉพาะด้านบนซ้าย ล่างซ้าย ล่างขวา ด้านละ 30 สีขอบสีเขียว
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        border: Border.all(width: 1.5, color: Colors.green)),
                    // ซ่อนเส้นใต้ข้อความในกล่อง Dropdown
                    child: DropdownButtonHideUnderline(
                      // สร้าง Dropdown
                      child: DropdownButton(
                        value: dropdownValue,
                        onChanged: (String? newValue) {
                          // Set ค่าเมื่อเลือกค่าใหม่
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        // กำหนด item ใน Dropdown
                        items: activity
                            .map(
                              (String value) => DropdownMenuItem(
                                value: value,
                                // กล่องข้อความยาว 200 และ ข้อความอยู่ตรงกลาง
                                child: Container(
                                  width: 200,
                                  child: Text(
                                    value,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
        // Padding เพื่อดันด้านล่างเมื่อเปิด Keyboard ความสูงที่จะดันเท่ากับขนาด Keyboard ที่มาแทรก 90%
        Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom * 0.6),
          child: Column(
            children: [
              // แสดง Text เมื่อ isEmpty เท่ากับ true
              if (isEmpty)
                Text(
                  'กรุณากรอกข้อมูลให้ครบถ้วน',
                  style: TextStyle(color: Colors.red),
                ),
              SizedBox(height: 10),
              // กล่องสูง 50 ยาว 200
              Container(
                height: 50,
                width: 200,
                // ปุ่มข้อความขอบมนเฉพาะด้านบนซ้าย ล่างซ้าย ล่างขวา ด้านละ 30 สีพื้นหลังสีเขียว สีเบื้องหน้าสีดำ
                child: TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      )),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                  onPressed: checkInput,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 10),
                      Text(
                        'คำนวณ',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }

  // ฟังก์ชันในการตรวจสอบค่าที่ได้รับจาก User
  void checkInput() {
    titleController.text == '' ||
            amountController.text == '' ||
            weightController.text == '' ||
            heightController.text == '' ||
            ageController.text == ''
        ? setState(() {
            isEmpty = true;
          })
        : tdeeCalculator();
  }

  // ฟังก์ชันในการคำนวณ TDEE ต่อวันและเปิด AlertDialog
  void tdeeCalculator() {
    // ปิด Bottom Dialog
    Navigator.pop(context);

    // ปิด Keyboard
    FocusScope.of(context).unfocus();

    double bmr;

    // คำนวณ BMR
    isSelected[0]
        ? bmr = 66 +
            (13.7 * double.parse(weightController.text)) +
            (5 * double.parse(heightController.text)) -
            (6.8 * int.parse(ageController.text))
        : bmr = 655 +
            (9.6 * double.parse(weightController.text)) +
            (1.8 * double.parse(heightController.text)) -
            (4.7 * int.parse(ageController.text));

    // คำนวณ TDEE
    switch (dropdownValue) {
      case 'ไม่ออกกำลังกาย':
        tdee = (bmr * 1.2).roundToDouble();
        break;
      case '1 - 3 วัน/สัปดาห์':
        tdee = (bmr * 1.375).roundToDouble();
        break;
      case '3 - 5 วัน/สัปดาห์':
        tdee = (bmr * 1.55).roundToDouble();
        break;
      case '6 - 7 วัน/สัปดาห์':
        tdee = (bmr * 1.725).roundToDouble();
        break;
      case 'ออกกำลังกายทุกวันเช้าเย็น':
        tdee = (bmr * 1.9).roundToDouble();
        break;
    }

    // เปิด AlertDialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('TDEE Report'),
          content: Text('TDEE = $tdee แคลอรี่'),
          actions: [
            TextButton(
              onPressed: () {
                // ปิด AlertDialog
                Navigator.pop(context);
              },
              child: Text(
                'ปิด',
                style: TextStyle(color: Colors.red),
              ),
            ),
            //
            TextButton(
              onPressed: () async {
                // ฟังก์ชันสุ่มอาหาร
                randomMeals(amountController.text);
                Navigator.pop(context);
              },
              child: Text(
                'สุ่มมื้ออาหาร',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }

  // ฟังก์ชันในการสุ่มอาหาร
  void randomMeals(String mealsNumber) async {
    num totalCalories = 0;
    List<String> randomFoods = [];

    final prefs = await SharedPreferences.getInstance();

    // loop สุ่มเมนูอาหาร
    for (var i = 0; i < int.parse(mealsNumber); i++) {
      // Map ข้อมูลที่สุ่มจาก List foods
      Map randomFood = foods[Random().nextInt(foods.length)];
      // แยกข้อมูลในรูปของ key และ value
      randomFood.forEach((key, value) => key == 'avg_calories'
          ? totalCalories += value
          : randomFoods.add(value));
    }

    print('ชื่อชุดอาหาร: ${titleController.text}');
    print('จำนวนมื้อ: $mealsNumber');
    print('TDEE: $tdee');
    print('แคลอรี่โดยประมาณ: $totalCalories');
    print('อาหาร: $randomFoods');

    // เก็บ Data ในรูปของ key และ value
    prefs.setString('title', titleController.text);
    prefs.setDouble('tdee', tdee);
    prefs.setString('calories', totalCalories.toString());
    prefs.setStringList('foods', randomFoods);
  }
}
