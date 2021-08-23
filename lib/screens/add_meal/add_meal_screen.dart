import 'package:flutter/material.dart';
import 'package:flutter_mealset/screens/add_meal/components/gender.dart';
import 'package:flutter_mealset/screens/add_meal/components/text_input.dart';

class AddMeal extends StatefulWidget {
  AddMeal({Key? key}) : super(key: key);

  @override
  _AddMealState createState() => _AddMealState();
}

class _AddMealState extends State<AddMeal> {
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

  late double bmr;

  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final ageController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
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
                'คำนวณแคลอรี่',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
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
              TextInput(
                title: 'ส่วนสูง (เซนติเมตร): ',
                hintText: '175',
                controller: heightController,
              ),
              SizedBox(height: 20),
              TextInput(
                title: 'น้ำหนัก (กิโลกรัม): ',
                hintText: '70',
                controller: weightController,
              ),
              SizedBox(height: 20),
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
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        border: Border.all(width: 1.5, color: Colors.green)),
                    // ซ่อนเส้นใต้ข้อความ
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: dropdownValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
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
              SizedBox(height: 30),
            ],
          ),
        ),

        Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: [
              if (isEmpty)
                Text(
                  'กรุณากรอกข้อมูลให้ครบถ้วน',
                  style: TextStyle(color: Colors.red),
                ),
              SizedBox(height: 10),
              Container(
                height: 50,
                width: 200,
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
        SizedBox(height: 40),
      ],
    );
  }

  void checkInput() {
    AlertDialog alertDialog = AlertDialog(
      title: Text('BMR Calculator'),
      content: Text('BMR = $bmr แคลอรี่'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'ปิด',
            style: TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'สุ่มมื้ออาหาร',
            style: TextStyle(color: Colors.green),
          ),
        ),
      ],
    );

    weightController.text == '' ||
            heightController.text == '' ||
            ageController.text == ''
        ? setState(() {
            isEmpty = true;
          })
        : {
            bmrCalculator(),
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return alertDialog;
              },
            )
          };
  }

  void bmrCalculator() {
    isSelected[0]
        ? bmr = 66 +
            (13.7 * double.parse(weightController.text)) +
            (5 * double.parse(heightController.text)) -
            (6.8 * int.parse(ageController.text))
        : bmr = 665 +
            (9.6 * double.parse(weightController.text)) +
            (1.8 * double.parse(heightController.text)) -
            (4.7 * int.parse(ageController.text));

    switch (dropdownValue) {
      case 'ไม่ออกกำลังกาย':
        bmr *= 1.2;
        break;
      case '1 - 3 วัน/สัปดาห์':
        bmr *= 1.375;
        break;
      case '3 - 5 วัน/สัปดาห์':
        bmr *= 1.55;
        break;
      case '6 - 7 วัน/สัปดาห์':
        bmr *= 1.725;
        break;
      case 'ออกกำลังกายทุกวันเช้าเย็น':
        bmr *= 1.9;
        break;
    }
    print(bmr);
    setState(() {
      isEmpty = false;
    });
  }
}
