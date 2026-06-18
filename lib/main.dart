import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'LoginPage.dart';
import 'DashboardPage.dart';
import 'CounterPage.dart';
import 'CrudPage.dart';
import 'ApiPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('mahasiswaBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PMP2411500025',
      debugShowCheckedModeBanner: true,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/dashboard': (context) => DashboardPage(),
        '/counter': (context) => const CounterPage(),
        '/crud': (context) => const CrudPage(),
        '/api': (context) => const ApiPage(),
      },
    );
  }
}