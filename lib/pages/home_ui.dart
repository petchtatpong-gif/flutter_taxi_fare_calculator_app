import 'package:flutter/material.dart';
import 'package:taxi_fare_calculator/theme/app_theme.dart';
import 'taxi_fare_ui.dart';
import 'about_ui.dart';
import 'history_ui.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const TaxiFareUI(),
    const AboutUI(),
    const HistoryUI(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Taxi Fare"),
        backgroundColor: AppTheme.primaryYellow,
        elevation: 0,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: AppTheme.primaryYellow,
        unselectedItemColor: AppTheme.secondaryGrey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.monitor_weight), label: 'Taxi Fare'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
      ),
    );
  }
}
