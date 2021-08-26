import 'package:flutter/material.dart';
import 'package:flutter_mealset/screens/home/components/passage.dart';
import 'package:flutter_mealset/screens/list/list_screen.dart';
import 'package:audioplayers/audioplayers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            // ขยายข้างในกล่อง
            constraints: BoxConstraints.expand(),
            child: Image.asset(
              'assets/images/wallpaper.jpg',
              // ปรับขนาด Image ให้เต็ม Contanier
              fit: BoxFit.cover,
            ),
          ),
          // กำหนดตำแหน่ง
          Positioned(
            // อยู่ห่างด้านบนตามขนาดความสูง 10% 
            top: MediaQuery.of(context).size.height * 0.1,
            // อยู่ห่างด้านซ้ายตามขนาดความสูง 10% 
            left: MediaQuery.of(context).size.width * 0.1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Passage(passage: 'ยินดีต้อนรับ'),
                Passage(passage: 'สู่'),
                Passage(
                  passage: 'Mealset',
                  color: Colors.green,
                )
              ],
            ),
          ),
          // กำหนดตำแหน่ง
          Positioned(
            // อยู่ห่างด้านล่างตามขนาดความสูง 5% 
            bottom: MediaQuery.of(context).size.height * 0.05,
            // อยู่ห่างด้านขวาตามขนาดความกว้าง 5%
            right: MediaQuery.of(context).size.width * 0.05,
            child: Container(
              height: 60,
              width: 220,
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
                onPressed: () {
                  // เล่นเสียง
                  AudioCache().play('sounds/welcome.wav');
                  // กำหนดดีเลย์ 800 มิลลิวินาที
                  Future.delayed(Duration(milliseconds: 800), () {
                    // นำทางไปยังหน้า ListScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListScreen(),
                      ),
                    );
                  });
                },
                child: Text(
                  'เริ่มต้นใช้งาน',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
