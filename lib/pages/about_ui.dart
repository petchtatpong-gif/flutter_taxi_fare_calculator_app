import 'package:flutter/material.dart';
import 'package:taxi_fare_calculator/theme/app_theme.dart';

class AboutUI extends StatelessWidget {
  const AboutUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
        backgroundColor: AppTheme.primaryYellow,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("เกี่ยวกับแอป", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.primaryYellow)),
            const SizedBox(height: 10),
            Image.asset('assets/taxi_image.jpg', height: 100),
            const SizedBox(height: 20),
            const Text(
              "แอปพลิเคชันคำนวณค่าโดยสารแท็กซี่ ออกแบบมาเพื่อช่วยให้ผู้ใช้งานสามารถประมาณค่าใช้จ่ายในการเดินทางได้อย่างแม่นยำ โดยคำนวณจากระยะทางและเวลารถติด",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text("สูตรการคำนวณค่าโดยสาร:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text(
              "1. ระยะทาง 0-1 กม.: 35 บาท\n"
              "2. ระยะทาง 2-10 กม.: 35 บาท + (ระยะทาง - 1 กม.) * 6.50 บาท/กม.\n"
              "3. ระยะทาง 10-20 กม.: 35 บาท + (9 กม. * 6.50 บาท) + (ระยะทาง - 10 กม.) * 7.00 บาท/กม.\n"
              "4. ระยะทาง 20-40 กม.: 35 บาท + (9 กม. * 6.50 บาท) + (10 กม. * 7.00 บาท) + (ระยะทาง - 20 กม.) * 8.00 บาท/กม.\n"
              "5. ระยะทาง 40-60 กม.: 35 บาท + (9 กม. * 6.50 บาท) + (10 กม. * 7.00 บาท) + (20 กม. * 8.00 บาท) + (ระยะทาง - 40 กม.) * 8.50 บาท/กม.\n"
              "6. ระยะทาง 60-80 กม.: 35 บาท + (9 กม. * 6.50 บาท) + (10 กม. * 7.00 บาท) + (20 กม. * 8.00 บาท) + (20 กม. * 8.50 บาท) + (ระยะทาง - 60 กม.) * 9.00 บาท/กม.\n"
              "7. ระยะทางมากกว่า 80 กม.: 35 บาท + (9 กม. * 6.50 บาท) + (10 กม. * 7.00 บาท) + (20 กม. * 8.00 บาท) + (20 กม. * 8.50 บาท) + (20 กม. * 9.00 บาท) + (ระยะทาง - 80 กม.) * 10.50 บาท/กม.",
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 20),
            const Text("เวลารถติด: นาทีละ 3.00 บาท", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            const Center(child: Text("พัฒนาโดยทีมงาน Taxi Fare Project", style: TextStyle(color: Colors.grey))),
          ],
        ),
      ),
    );
  }
}
