// lib/DashboardPage.dart
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard Materi Navigasi')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Hallo, Fathurrahman Safari Lubis"), // Masukkan namamu
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
