import 'package:flutter/material.dart';
import 'package:taxi_fare_calculator/theme/app_theme.dart';
import '../history_manager.dart';

class HistoryUI extends StatefulWidget {
  const HistoryUI({super.key});

  @override
  State<HistoryUI> createState() => _HistoryUIState();
}

class _HistoryUIState extends State<HistoryUI> {
  @override
  Widget build(BuildContext context) {
    final history = getHistory();
    if (history.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/taxi_image.jpg', height: 100),
            const SizedBox(height: 16),
            const Icon(Icons.history, size: 100, color: Colors.grey),
            const SizedBox(height: 16),
            const Text("ยังไม่มีข้อมูลการคำนวณ", style: TextStyle(fontSize: 18)),
          ],
        ),
      );
    }

    return Column(
      children: [
        Image.asset('assets/taxi_image.jpg', height: 100),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: history.length,
            itemBuilder: (context, index) {
              final record = history[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const Icon(Icons.receipt),
                  title: Text("ราคา: ${record.totalFare.toStringAsFixed(2)} บาท"),
                  subtitle: Text(
                    "ระยะทาง: ${record.distance} กม. | เวลารถติด: ${record.waitTime} นาที | รถ: ${record.vehicleType}",
                  ),
                  trailing: Text(record.vehicleType.toString().split('.').last.toUpperCase()),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
