import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'common/routing/routes.dart';
import 'features/personal_expense_tracker/presentation/provider/expences_provider.dart';
import 'features/personal_expense_tracker/presentation/screens/main_page.dart';

void main() {

  runApp(ChangeNotifierProvider(
    create: (context) => ExpensesProvider(),
    child: Consumer<ExpensesProvider>(
        builder: (context, provider, child) {
          return ResponsiveSizer(
              builder: (context, orientation, screenType) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                      textScaleFactor: 1.0),
                  child: const MyApp(),
                );
              }
          );
        }
    ),
  ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenses Tracker',
      home: const MainPage(),
      routes: routingTable,
    );
  }
}
