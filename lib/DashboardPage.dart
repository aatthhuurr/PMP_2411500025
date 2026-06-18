import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String username = "";

  @override
  void initState() {
    super.initState();
    getData();
  }

  // AMBIL DATA USER
  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      username = prefs.getString('username') ?? "";
    });
  }

  // FUNCTION LOGOUT
  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.clear();

    Navigator.pushReplacementNamed(
      context,
      '/',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hallo, $username",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Login Berhasil",
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/crud');
              },
              child: const Text('CRUD Mahasiswa'),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: logout,
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}