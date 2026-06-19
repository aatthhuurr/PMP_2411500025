import 'package:flutter/material.dart';
import 'services/api_service.dart';

class ApiPage extends StatefulWidget {
  const ApiPage({super.key});

  @override
  State<ApiPage> createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  List mahasiswa = [];

  Future<void> getData() async {
    final data = await ApiService.getMahasiswa();

    setState(() {
      mahasiswa = data;
    });
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
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      bool berhasil =
                          await ApiService.deleteMahasiswa(
                        mahasiswa[index]['id'],
                      );

                      if (berhasil) {
                        getData();

                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Data berhasil dihapus',
                            ),
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}