import 'package:flutter/material.dart';
import 'package:tugas13_flutter/database/db_helper.dart';
import 'package:tugas13_flutter/model/siswa.dart';
import 'package:tugas13_flutter/textform.dart';
import 'package:tugas13_flutter/views/detail_page.dart';

class SiswaHomePage extends StatefulWidget {
  const SiswaHomePage({super.key});
  static const id = "/main";

  static void showAddDialog(BuildContext context, VoidCallback onSuccess) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final noController = TextEditingController();
    final yearController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A2A80),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.person_add_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Tambah Siswa Baru",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 16),

              // Nama
              TextFormConst(
                hintText: "Nama",
                controller: nameController,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama tidak boleh kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // NISN
              TextFormConst(
                hintText: "NISN",
                controller: noController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "NISN tidak boleh kosong";
                  } else if (value.length != 10) {
                    return "NISN harus 10 angka";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Tahun ajaran
              TextFormConst(
                hintText: "Tahun Ajaran",
                controller: yearController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Tahun ajaran tidak boleh kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Batal",
              style: TextStyle(
                color: Color(0xFF1A2A80),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1A2A80),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                final name = nameController.text;
                final no = int.tryParse(noController.text) ?? 0;
                final year = yearController.text;

                await DbHelper.registerSiswa(
                  Siswa(name: name, no: no, year: year),
                );
                onSuccess();
                Navigator.pop(context);
              }
            },
            child: const Text("Simpan", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  State<SiswaHomePage> createState() => SiswaHomePageState();
}

class SiswaHomePageState extends State<SiswaHomePage> {
  List<Siswa> _students = [];

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  Future<void> refreshData() async {
    final data = await DbHelper.getAllSiswa();
    setState(() {
      _students = data;
    });
  }

  void showEditDialog(Siswa student) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: student.name);
    final noController = TextEditingController(text: student.no.toString());
    final yearController = TextEditingController(text: student.year);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A2A80),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.edit, color: Colors.white, size: 28),
              ),
              const SizedBox(height: 16),
              const Text(
                "Edit Data Siswa",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 16),

              TextFormConst(
                hintText: "Nama",
                controller: nameController,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama tidak boleh kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // NISN
              TextFormConst(
                hintText: "NISN",
                controller: noController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "NISN tidak boleh kosong";
                  } else if (value.length != 10) {
                    return "NISN harus 10 angka";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Tahun ajaran
              TextFormConst(
                hintText: "Tahun Ajaran",
                controller: yearController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Tahun ajaran tidak boleh kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Batal",
              style: TextStyle(
                color: Color(0xFF1A2A80),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1A2A80),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                final name = nameController.text;
                final no = int.tryParse(noController.text) ?? 0;
                final year = yearController.text;

                await DbHelper.updateSiswa(
                  Siswa(id: student.id, name: name, no: no, year: year),
                );
                await refreshData();
                Navigator.pop(context);
              }
            },
            child: const Text("Update", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void deleteStudent(int id) async {
    await DbHelper.deleteSiswa(id);
    await refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Data Siswa",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1A2A80),
        foregroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: _students.isEmpty
            ? const Center(
                child: Text(
                  "Belum ada data siswa",
                  style: TextStyle(color: Colors.grey),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: _students.length,
                itemBuilder: (context, index) {
                  final student = _students[index];
                  return Card(
                    color: Colors.grey[50],
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFF1A2A80),
                        child: Text(
                          student.name.isNotEmpty
                              ? student.name[0].toUpperCase()
                              : '',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        student.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("NISN: ${student.no}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Color(0xFF1A2A80),
                              ),
                              onPressed: () => showEditDialog(student),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    contentPadding: const EdgeInsets.fromLTRB(
                                      24,
                                      24,
                                      24,
                                      0,
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.warning_amber_rounded,
                                            color: Colors.red,
                                            size: 32,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        const Text(
                                          "Hapus Data Siswa",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF1E293B),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          "Apakah anda yakin ingin menghapus data siswa ini?",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFF475569),
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.grey,
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text(
                                          "Batal",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                        ),
                                        onPressed: () async {
                                          deleteStudent(student.id!);
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "Hapus",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailPage(student: student),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
