import 'package:flutter/material.dart';
import 'package:tugas13_flutter/database/db_helper.dart';
import 'package:tugas13_flutter/model/user.dart';
import 'package:tugas13_flutter/textform.dart';

class TugasSebelas extends StatefulWidget {
  const TugasSebelas({super.key});

  @override
  State<TugasSebelas> createState() => _TugasSebelasState();
}

class _TugasSebelasState extends State<TugasSebelas> {
  List<Siswa> siswa = [];
  @override
  void initState() {
    super.initState();
    getUser();
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  Future<void> getUser() async {
    final dataSiswa = await DbHelper.getAllPenghuni();
    print(dataSiswa);
    setState(() {
      siswa = dataSiswa;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                'Edit Data',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Text(
                  //   "Formulir",
                  //   style: TextStyle(
                  //     fontSize: 25,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.black,
                  //   ),
                  // ),
                  SizedBox(height: 12),
                  TextFormConst(
                    hintText: "Nama",
                    controller: nameController,
                    keyboardType: TextInputType.name,
                  ),
                  SizedBox(height: 12),
                  TextFormConst(
                    hintText: "Umur",
                    controller: ageController,
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 12),
                  TextFormConst(
                    hintText: "Tanggal Masuk",
                    controller: yearController,
                    keyboardType: TextInputType.number,
                  ),

                  SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff21BDCA),
                      fixedSize: Size(360, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () async {
                      final name = nameController.text.trim();
                      final age = ageController.text.trim();
                      final year = yearController.text.trim();

                      if (name.isEmpty || age.isEmpty || year.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Nama, Phone, No Kamar, Asal Kota tidak boleh kosong",
                            ),
                          ),
                        );

                        return;
                      }
                      final siswa = Siswa(name: name, age: age, year: year);
                      await DbHelper.registerSiswa(siswa);
                      Future.delayed(const Duration(seconds: 1)).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Pendataan berhasil")),
                        );
                      });
                      Navigator.pop(context);
                      getUser();
                      setState(() {});
                    },

                    child: Text(
                      "Simpan Data",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        backgroundColor: Color(0xFF1A2A80),
        child: Icon(Icons.add, color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        // child: Padding(
        //   padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text(
            //   "Formulir",
            //   style: TextStyle(
            //     fontSize: 25,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.black,
            //   ),
            // ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: siswa.length,
              itemBuilder: (BuildContext context, int index) {
                final dataSiswaLogin = siswa[index];
                // return ListTile(
                //   title: Text(dataUserLogin.name),
                //   subtitle: Text(dataUserLogin.phone,),

                // );
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 6),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.2),
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Color(0xff21BDCA),
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          // spacing: 12,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Nama : ${dataSiswaLogin.name}"),
                            Text("Umur : ${dataSiswaLogin.age}"),
                            Text("Tahun Masuk: ${dataSiswaLogin.year}"),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              nameController.text = dataSiswaLogin.name;
                              ageController.text = dataSiswaLogin.age;
                              yearController.text = dataSiswaLogin.year;

                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                    'Edit Data',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormConst(
                                        controller: nameController
                                          ..text = dataSiswaLogin.name,
                                        hintText: 'Nama',
                                        keyboardType: TextInputType.name,
                                      ),
                                      SizedBox(height: 12),
                                      TextFormConst(
                                        controller: ageController
                                          ..text = dataSiswaLogin.age,
                                        hintText: 'age',
                                        keyboardType: TextInputType.number,
                                      ),
                                      SizedBox(height: 12),

                                      TextFormConst(
                                        controller: yearController
                                          ..text = dataSiswaLogin.year,
                                        hintText: 'Tahun Masuk',
                                        keyboardType: TextInputType.number,
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xff21BDCA),
                                        fixedSize: Size(360, 30),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        final dataUser = Siswa(
                                          id: dataSiswaLogin.id!,
                                          name: nameController.text,
                                          age: ageController.text,
                                          year: yearController.text.trim(),
                                        );
                                        DbHelper.updateSiswa(dataUser);
                                        getUser();
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Simpan',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xff21BDCA),
                                        fixedSize: Size(360, 30),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(
                                        'Batal',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              DbHelper.deleteSiswa(dataSiswaLogin.id!);

                              getUser();
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      // ),
    );
  }
}
