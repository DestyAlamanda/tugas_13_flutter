import 'package:flutter/material.dart';
import 'package:tugas13_flutter/auth/log_out_button.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tentang Sekolah"),
        backgroundColor: const Color(0xFF1A2A80),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Color(0xFF1A2A80),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.school, size: 60, color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "SMA 113 Jakarta",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "SMA Negeri 113 Jakarta adalah sekolah menengah atas yang berlokasi di Lubang Buaya, Jakarta Timur. "
                      "Sekolah ini dikenal dengan kualitas akademik yang baik dan berbagai kegiatan ekstrakurikuler yang mendukung perkembangan siswa.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    const SizedBox(height: 20),
                    _buildInfoRow(
                      Icons.location_on,
                      "Alamat",
                      "Jl. Al Baidho I No.10, Lubang Buaya, Jakarta Timur",
                    ),
                    const SizedBox(height: 10),
                    _buildInfoRow(Icons.phone, "Telepon", "(021) 8408034"),
                    const SizedBox(height: 10),
                    _buildInfoRow(
                      Icons.email,
                      "Email",
                      "sman113jakarta@yahoo.com",
                    ),
                    const SizedBox(height: 10),
                    _buildInfoRow(
                      Icons.language,
                      "Website",
                      "http://www.sman113jakarta.sch.id",
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(width: 360, height: 40, child: const LogOutButton()),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String info) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: const Color(0xFF1A2A80)),
        const SizedBox(width: 8),
        Flexible(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "$label: ",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontSize: 14,
              ),
              children: [
                TextSpan(
                  text: info,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
