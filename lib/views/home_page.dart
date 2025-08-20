import 'package:flutter/material.dart';
import 'package:tugas13_flutter/database/db_helper.dart';
import 'package:tugas13_flutter/model/siswa.dart';
import 'package:tugas13_flutter/textform.dart';
import 'package:tugas13_flutter/views/detail_page.dart';

class SiswaHomePage extends StatefulWidget {
  const SiswaHomePage({super.key});
  static const id = "/main";
  static void showAddDialog(BuildContext context, VoidCallback onSuccess) {
    final nameController = TextEditingController();
    final ageController = TextEditingController();
    final yearController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: EdgeInsets.fromLTRB(24, 24, 24, 0),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Color(0xFF1A2A80),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.person_add_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
            SizedBox(height: 16),

            Text(
              "Tambah Siswa Baru",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E293B),
              ),
            ),
            SizedBox(height: 16),

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
            SizedBox(height: 20),
          ],
        ),

        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Batal",
              style: TextStyle(
                color: Color(0xFF1A2A80),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF1A2A80),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onPressed: () async {
              final name = nameController.text;
              final age = int.tryParse(ageController.text) ?? 0;
              final year = yearController.text;

              if (name.isNotEmpty && year.isNotEmpty) {
                await DbHelper.registerSiswa(
                  Siswa(name: name, age: age, year: year),
                );
                onSuccess();
                Navigator.pop(context);
              }
            },
            child: Text("Simpan", style: TextStyle(color: Colors.white)),
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
        contentPadding: EdgeInsets.fromLTRB(24, 24, 24, 0),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Ikon Edit dalam Container
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Color(0xFF1A2A80),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.edit, color: Colors.white, size: 28),
            ),
            SizedBox(height: 16),

            Text(
              "Edit Data Siswa",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E293B),
              ),
            ),
            SizedBox(height: 16),

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
            SizedBox(height: 20),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Batal",
              style: TextStyle(
                color: Color(0xFF1A2A80),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF1A2A80),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
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
            child: Text("Update", style: TextStyle(color: Colors.white)),
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
        centerTitle: true,
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
                          student.name.isNotEmpty
                              ? student.name[0].toUpperCase()
                              : '',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        student.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("${student.age} tahun"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => showEditDialog(student),
                            ),
                          ),

                          SizedBox(width: 8),

                          Container(
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    contentPadding: EdgeInsets.fromLTRB(
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
                                            color: Colors.orange.withOpacity(
                                              0.2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.warning_amber_rounded,
                                            color: Colors.orange,
                                            size: 32,
                                          ),
                                        ),
                                        SizedBox(height: 16),

                                        Text(
                                          "Hapus Data Siswa",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF1E293B),
                                          ),
                                        ),
                                        SizedBox(height: 10),

                                        Text(
                                          "Apakah anda yakin ingin menghapus data siswa ini?",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFF475569),
                                          ),
                                        ),
                                        SizedBox(height: 24),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.grey,
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                        child: Text(
                                          "Batal",
                                          style: TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.orange,
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
