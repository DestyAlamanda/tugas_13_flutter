import 'package:flutter/material.dart';
import 'package:tugas13_flutter/database/db_helper.dart';
import 'package:tugas13_flutter/model/siswa.dart';
import 'package:tugas13_flutter/textform.dart';

class SiswaHomePage extends StatefulWidget {
  const SiswaHomePage({super.key});
  static const id = "/main";
  static void showAddDialog(BuildContext context, VoidCallback onSuccess) {
    final nameController = TextEditingController();
    final ageController = TextEditingController();
    final yearController = TextEditingController();
    // final phoneController = TextEditingController();
    // final passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text("Tambah Siswa"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TextField(
            //   controller: nameController,
            //   decoration: InputDecoration(labelText: "Nama"),
            // ),
            TextFormConst(
              hintText: "Nama",
              controller: nameController,
              keyboardType: TextInputType.name,
            ),
            SizedBox(height: 10),
            TextFormConst(
              hintText: "Umur",
              controller: ageController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextFormConst(
              hintText: "Tahun Ajaran",
              controller: yearController,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () async {
              final name = nameController.text;
              final age = int.tryParse(ageController.text) ?? 0;
              final year = yearController.text;

              if (name.isNotEmpty && year.isNotEmpty) {
                await DbHelper.registerSiswa(
                  Siswa(
                    name: name,
                    age: age,
                    year: year,
                    // phone: phone,
                    // password: password,
                  ),
                );
                onSuccess();
                Navigator.pop(context);
              }
            },
            child: Text("Simpan"),
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
    final nameController = TextEditingController(text: student.name);
    final ageController = TextEditingController(text: student.age.toString());
    final yearController = TextEditingController(text: student.year);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text("Edit Data Siswa"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormConst(
              hintText: "Nama",
              controller: nameController,
              keyboardType: TextInputType.name,
            ),
            SizedBox(height: 10),
            TextFormConst(
              hintText: "Umur",
              controller: ageController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextFormConst(
              hintText: "Tahun Ajaran",
              controller: yearController,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () async {
              final name = nameController.text;
              final age = int.tryParse(ageController.text) ?? 0;
              final year = yearController.text;

              if (name.isNotEmpty && year.isNotEmpty) {
                await DbHelper.updateSiswa(
                  Siswa(id: student.id, name: name, age: age, year: year),
                );
                await refreshData();
                Navigator.pop(context);
              }
            },
            child: Text("Update"),
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
      appBar: AppBar(
        title: Text(
          "Data Siswa",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF1A2A80),
        foregroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: _students.isEmpty
            ? const Center(child: Text("Belum ada data siswa"))
            : ListView.builder(
                padding: EdgeInsets.all(12),
                itemCount: _students.length,
                itemBuilder: (context, index) {
                  final student = _students[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 6),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color(0xFF1A2A80),
                        child: Text(
                          student.id?.toString() ?? '',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        student.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("${student.age} tahun • ${student.year}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => showEditDialog(student),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  title: Text("Konfirmasi"),
                                  content: Text("Yakin untuk dihapus?"),
                                  actions: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.grey,
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("Batal"),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF1A2A80),
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
                                      child: Text(
                                        "Hapus",
                                        style: TextStyle(color: Colors.white),
                                      ),
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
      ),
    );
  }
}
