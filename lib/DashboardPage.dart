// lib/DashboardPage.dart
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 1. Mengambil argumen yang dikirim melalui Named Route
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String username = args['username'] ?? "";
    final String password = args['password'] ?? "";

    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 2. Menampilkan data sesuai instruksi tugas
            Text(
              "Hallo, $username",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Kembali ke Home'),
              onPressed: () {
                // Perintah untuk kembali ke halaman sebelumnya
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
