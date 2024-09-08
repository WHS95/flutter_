import 'package:flutter/material.dart';
import 'main_screen.dart'; // MainScreen import 추가

// SplashScreen 위젯 정의
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

// SplashScreen의 상태 클래스 정의
class SplashScreenState extends State<SplashScreen> {
  static const int splashDuration = 2; // 스플래시 화면 지속 시간 (초)
  static const String imagePath = 'assets/business-card.png'; // 이미지 경로
  static const String titleText = 'Business Card'; // 타이틀 텍스트

  @override
  void initState() {
    super.initState();
    // splashDuration 초 뒤에 MainScreen으로 이동
    Future.delayed(const Duration(seconds: splashDuration), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 화면의 UI를 정의
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 이미지 표시
            Image.asset(
              imagePath,
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            // 텍스트 표시
            const Text(
              titleText,
              style: TextStyle(
                color: Colors.green,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
