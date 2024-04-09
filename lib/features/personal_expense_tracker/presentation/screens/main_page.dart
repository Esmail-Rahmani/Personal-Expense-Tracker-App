import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


import 'package:flutter/material.dart';

import '../widgets/add_expense_widget.dart';
import 'expenses_list_page.dart';
import 'home_page.dart';
import 'local_notification_settings.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedTab = 0;

  List _pages = [
    HomePage(),
    ExpensesPage(),
    AddExpensePage(),
    Center(
      child: Text("Products"),
    ),
    SetReminderPage(),
  ];

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: _pages[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) => _changeTab(index),
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.price_change), label: "Expenses"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_rounded,size: 48,), label: "Add new"),
          BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined), label: "categorid"),
          BottomNavigationBarItem(
              icon: Icon(Icons.stacked_line_chart_rounded), label: "Statistics"),
        ],
      ),
    );
  }
}
