import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CrudPage extends StatefulWidget {
  const CrudPage({super.key});

  @override
  State<CrudPage> createState() => _CrudPageState();
}

class _CrudPageState extends State<CrudPage> {
  final Box mahasiswaBox = Hive.box('mahasiswaBox');

  final TextEditingController nimController = TextEditingController();
  final TextEditingController namaController = TextEditingController();

  bool isEdit = false;
  int selectedIndex = -1;

  void simpanData() {
    if (nimController.text.isEmpty || namaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('NIM dan Nama wajib diisi')),
      );
      return;
    }

    if (isEdit) {
      mahasiswaBox.putAt(selectedIndex, {
        'nim': nimController.text,
        'nama': namaController.text,
      });
    } else {
      mahasiswaBox.add({
        'nim': nimController.text,
        'nama': namaController.text,
      });
    }

    nimController.clear();
    namaController.clear();

    isEdit = false;
    selectedIndex = -1;

    setState(() {});
  }

  void editData(int index) {
    final data = mahasiswaBox.getAt(index);

    nimController.text = data['nim'];
    namaController.text = data['nama'];

    isEdit = true;
    selectedIndex = index;

    setState(() {});
  }

  void hapusData(int index) {
    mahasiswaBox.deleteAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CRUD Mahasiswa"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nimController,
              decoration: const InputDecoration(
                labelText: "NIM",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                labelText: "Nama",
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: simpanData,
              child: Text(isEdit ? "Update" : "Tambah"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: mahasiswaBox.length,
                itemBuilder: (context, index) {
                  final data = mahasiswaBox.getAt(index);

                  return Card(
                    child: ListTile(
                      title: Text(data['nama']),
                      subtitle: Text(data['nim']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => editData(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => hapusData(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}