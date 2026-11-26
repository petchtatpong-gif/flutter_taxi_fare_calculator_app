import 'package:flutter/material.dart';
import 'package:taxi_fare_calculator/theme/app_theme.dart';
import '../history_manager.dart';

enum VehicleType {
  standard,
  suv,
  premium,
}

List<CalculationRecord> _history = [];

class TaxiFareUI extends StatefulWidget {
  const TaxiFareUI({super.key});

  @override
  State<TaxiFareUI> createState() => _TaxiFareUIState();
}

class _TaxiFareUIState extends State<TaxiFareUI> {
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _waitTimeController = TextEditingController();
  double _totalFare = 0.0;
  String _errorMessage = "";
  VehicleType _selectedVehicleType = VehicleType.standard;

  Map<VehicleType, double> _getVehicleMultipliers() {
    return {
      VehicleType.standard: 1.0,
      VehicleType.suv: 1.5,
      VehicleType.premium: 2.0,
    };
  }

  void _calculateFare() {
    final double? distance = double.tryParse(_distanceController.text);
    final double? waitTime = double.tryParse(_waitTimeController.text);

    if (distance != null && distance >= 0) {
      double baseFare = 0.0;

      if (distance <= 1) {
        baseFare = 35.0;
      } else if (distance <= 10) {
        baseFare = 35.0 + (distance - 1) * 6.50;
      } else if (distance <= 20) {
        baseFare = 35.0 + (9 * 6.50) + (distance - 10) * 7.00;
      } else if (distance <= 40) {
        baseFare = 35.0 + (9 * 6.50) + (10 * 7.00) + (distance - 20) * 8.00;
      } else if (distance <= 60) {
        baseFare = 35.0 + (9 * 6.50) + (10 * 7.00) + (20 * 8.00) + (distance - 40) * 8.50;
      } else if (distance <= 80) {
        baseFare = 35.0 + (9 * 6.50) + (10 * 7.00) + (20 * 8.00) + (20 * 8.50) + (distance - 60) * 9.00;
      } else {
        baseFare = 35.0 + (9 * 6.50) + (10 * 7.00) + (20 * 8.00) + (20 * 8.50) + (20 * 9.00) + (distance - 80) * 10.50;
      }

      if (waitTime != null && waitTime > 0) {
        baseFare += waitTime * 3.00;
      }

      double multiplier = _getVehicleMultipliers()[_selectedVehicleType] ?? 1.0;
      double finalFare = baseFare * multiplier;

      setState(() {
        _totalFare = finalFare;
        _errorMessage = "";
      });
    } else {
      setState(() {
        _totalFare = 0.0;
        _errorMessage = "กรุณาระบุระยะทางที่ถูกต้อง";
      });
    }
  }

  void _saveToHistory() {
    if (_totalFare > 0) {
      final record = CalculationRecord(
        id: DateTime.now().toString(),
        distance: _distanceController.text.isEmpty ? 0.0 : double.tryParse(_distanceController.text) ?? 0.0,
        waitTime: _waitTimeController.text.isEmpty ? 0.0 : double.tryParse(_waitTimeController.text) ?? 0.0,
        vehicleType: _selectedVehicleType,
        totalFare: _totalFare,
        date: DateTime.now(),
      );
      saveRecord(record);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("บันทึกประวัติสำเร็จ")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Taxi Fare"),
        backgroundColor: AppTheme.primaryYellow,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("Taxi Fare",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.primaryYellow)),
            const SizedBox(height: 10),
            Image.asset('assets/taxi_image.jpg', height: 100, fit: BoxFit.contain),
            const SizedBox(height: 20),
            const Text("ระยะทาง (กม.)",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextField(
              controller: _distanceController,
              decoration: const InputDecoration(
                hintText: "ระบุระยะทาง",
                prefixIcon: Icon(Icons.map),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            const Text("เวลารถติด (นาที)",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextField(
              controller: _waitTimeController,
              decoration: const InputDecoration(
                hintText: "ระบุเวลารถติด",
                prefixIcon: Icon(Icons.timer),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            const Text("ประเภทรถ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: const Text("Standard"),
                    selected: _selectedVehicleType == VehicleType.standard,
                    onSelected: (selected) {
                      setState(() {
                        _selectedVehicleType = VehicleType.standard;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ChoiceChip(
                    label: const Text("SUV"),
                    selected: _selectedVehicleType == VehicleType.suv,
                    onSelected: (selected) {
                      setState(() {
                        _selectedVehicleType = VehicleType.suv;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ChoiceChip(
                    label: const Text("Premium"),
                    selected: _selectedVehicleType == VehicleType.premium,
                    onSelected: (selected) {
                      setState(() {
                        _selectedVehicleType = VehicleType.premium;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calculateFare,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text("คำนวณค่าโดยสาร"),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                _distanceController.clear();
                _waitTimeController.clear();
                setState(() {
                  _totalFare = 0.0;
                  _errorMessage = "";
                });
              },
              child: const Text("ล้างข้อมูล"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveToHistory,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text("บันทึกประวัติ"),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFFF9E79F),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  const Text("ผลการคำนวณ",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(
                    _totalFare.toStringAsFixed(2),
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.orange),
                  ),
                  const Text("บาท"),
                ],
              ),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    const Icon(Icons.warning, color: Colors.red),
                    const SizedBox(width: 10),
                    Text(_errorMessage, style: const TextStyle(color: Colors.red)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
