import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sqflite/sqflite.dart';

import 'common/routing/routes.dart';
import 'features/personal_expense_tracker/data/datasources/database.dart';
import 'features/personal_expense_tracker/data/datasources/local_notification.dart';
import 'features/personal_expense_tracker/presentation/provider/expences_provider.dart';
import 'features/personal_expense_tracker/presentation/screens/main_page.dart';

//If you just want the latest
import 'package:timezone/data/latest_all.dart' as tz;

void main() async{


  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  final DatabaseProvider databaseProvider = DatabaseProvider.instance;
  Database database = await databaseProvider.database;
  NotificationService notificationService = NotificationService();

  notificationService.initializeNotifications();

  // runApp(MyApp(databaseProvider: databaseProvider));

  runApp(ChangeNotifierProvider(
    create: (context) => ExpenseProvider(database),
    child: Consumer<ExpenseProvider>(
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
