import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'DashboardPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PMP2411500025',
      debugShowCheckedModeBanner: true,
      // Menggunakan Named Routes sesuai materi halaman 8
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/dashboard': (context) => DashboardPage(),
      },
    );
  }
}
