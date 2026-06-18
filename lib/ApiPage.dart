import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiPage extends StatefulWidget {
  const ApiPage({super.key});

  @override
  State<ApiPage> createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  List mahasiswa = [];

  Future<void> getData() async {
    final response = await http.get(
      Uri.parse(
        'https://api.atmaluhur.ac.id/pmp/mahasiswa',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        mahasiswa = jsonDecode(response.body);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REST API'),
      ),
      body: mahasiswa.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: mahasiswa.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      mahasiswa[index]['id'].toString(),
                    ),
                  ),
                  title: Text(
                    mahasiswa[index]['nama'],
                  ),
                  subtitle: Text(
                    mahasiswa[index]['nim'],
                  ),
                );
              },
            ),
    );
  }
}