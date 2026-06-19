import 'package:flutter/material.dart';
import '../models/mahasiswa.dart';
import '../services/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nimController = TextEditingController();
  final namaController = TextEditingController();

  List<Mahasiswa> mahasiswaList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  // Get data mahasiswa
  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });

    try {
      mahasiswaList = await ApiService.getMahasiswa();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Tambah data mahasiswa
  Future<void> tambahMahasiswa() async {
    if (nimController.text.isEmpty || namaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('NIM dan Nama harus diisi')),
      );
      return;
    }

    bool success = await ApiService.tambahMahasiswa(
      nim: nimController.text,
      nama: namaController.text,
    );

    if (success) {
      nimController.clear();
      namaController.clear();
      getData();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data berhasil ditambahkan')),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal menambahkan data')),
        );
      }
    }
  }


  Future<void> hapusMahasiswa(int id) async {
    bool success = await ApiService.deleteMahasiswa(id); // Pastikan nama method di ApiService sesuai

    if (success) {
      getData(); // Refresh data setelah dihapus
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data berhasil dihapus')),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal menghapus data')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Mahasiswa'),
      ),
      body: RefreshIndicator(
        onRefresh: getData,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: nimController,
                decoration: const InputDecoration(
                  labelText: 'NIM',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: tambahMahasiswa,
                  child: const Text('Tambah Mahasiswa'),
                ),
              ),
              const SizedBox(height: 20),
              
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: mahasiswaList.length,
                        itemBuilder: (context, index) {
                          final data = mahasiswaList[index];
                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text('${data.id}'),
                              ),
                              title: Text(data.nama),
                              subtitle: Text(data.nim),
                              // PERUBAHAN DI SINI: Menggunakan Row agar muat 2 tombol
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min, // Agar Row tidak memakan space horizontal penuh
                                children: [
                                  // Tombol Edit
                                  IconButton(
                                    icon: const Icon(Icons.edit, color: Colors.blue),
                                    onPressed: () {
                                      nimController.text = data.nim;
                                      namaController.text = data.nama;

                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text('Edit Mahasiswa'),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextField(
                                                  controller: nimController,
                                                  decoration: const InputDecoration(
                                                    labelText: 'NIM',
                                                    border: OutlineInputBorder(),
                                                  ),
                                                ),
                                                const SizedBox(height: 12),
                                                TextField(
                                                  controller: namaController,
                                                  decoration: const InputDecoration(
                                                    labelText: 'Nama',
                                                    border: OutlineInputBorder(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(context),
                                                child: const Text('Batal'),
                                              ),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  bool success = await ApiService.updateMahasiswa(
                                                    id: data.id.toInt(),
                                                    nim: nimController.text,
                                                    nama: namaController.text,
                                                  );
                                                  if (success) {
                                                    getData();
                                                    if (context.mounted) Navigator.pop(context);
                                                    if (context.mounted) {
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        const SnackBar(content: Text('Data berhasil diperbarui')),
                                                      );
                                                    }
                                                  } else {
                                                    if (context.mounted) {
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        const SnackBar(content: Text('Gagal memperbarui data')),
                                                      );
                                                    }
                                                  }
                                                },
                                                child: const Text('Simpan'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  // Tombol Delete Baru
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      // Opsional: Tambahkan dialog konfirmasi sebelum menghapus
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text('Hapus Data'),
                                          content: Text('Apakah Anda yakin ingin menghapus ${data.nama}?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(context),
                                              child: const Text('Batal'),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                hapusMahasiswa(data.id.toInt());
                                              },
                                              child: const Text('Hapus', style: TextStyle(color: Colors.white)),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}