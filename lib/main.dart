import 'package:flutter/material.dart';

import 'pages/area_page.dart';
import 'pages/calculator_page.dart';
import 'pages/input_page.dart';
import 'pages/radio_page.dart';
import 'pages/save_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const _screens = [
    CalculatorPage(),
    RadioPage(),
    AreaPage(),
    InputPage(),
    SavePage(),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.blue,
        child: BottomNavigationBar(
          unselectedLabelStyle: const TextStyle(color: Colors.grey),
          // backgroundColor: Colors.blue,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.calculate), label: 'calculator'),
            BottomNavigationBarItem(
                icon: Icon(Icons.radio_button_checked), label: 'radio'),
            BottomNavigationBarItem(
                icon: Icon(Icons.area_chart), label: 'area'),
            BottomNavigationBarItem(icon: Icon(Icons.input), label: 'input'),
            BottomNavigationBarItem(icon: Icon(Icons.save), label: 'save'),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return Center(child: const Text('calculator'));
      case 1:
        return Center(child: const Text('radio'));
      case 2:
        return Center(child: const Text('area'));
      case 3:
        return Center(child: const Text('input'));
      case 4:
        return Center(child: const Text('save'));
    }
    return Center(child: const Text('calculator'));
  }
}
