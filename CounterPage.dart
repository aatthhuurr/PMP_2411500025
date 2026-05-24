import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  // 1. Inisialisasi State dasar sesuai materi (halaman 7)
  int _counter = 0;

  // 2. Fungsi untuk menambah counter (halaman 7)
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // 3. TUGAS: Fungsi untuk mengurangi counter (halaman 11)
  void _decrementCounter() {
    setState(() {
      if (_counter > 0) _counter--;
    });
  }

  // 4. TUGAS: Fungsi untuk reset counter ke 0 (halaman 11)
  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter & setState()"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Counter"),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),

            // Baris tombol Add & Minus
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _decrementCounter,
                  child: const Text("Minus"),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  onPressed: _incrementCounter,
                  child: const Text("Add"),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // Tombol Reset
            OutlinedButton(
              onPressed: _resetCounter,
              style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
              child: const Text("Reset"),
            ),
          ],
        ),
      ),
    );
  }
}
