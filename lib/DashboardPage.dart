import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mengambil data lewat arguments sesuai materi halaman 10
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final String username = args['username'] ?? "";
    final String password = args['password'] ?? "";

    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hallo, $username",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Password: $password"),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Kembali ke Home'),
              onPressed: () {
                // Kembali ke halaman sebelumnya menggunakan pop sesuai materi halaman 5
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
