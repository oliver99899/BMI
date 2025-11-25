import 'package:flutter/material.dart';
import 'calculator_screen.dart';
import 'guide_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = Colors.blue.shade900;
    final Color bgBlue = Colors.blue.shade50;

    return Scaffold(
      backgroundColor: Colors.white, // Background Putih Bersih
      appBar: AppBar(
        title: const Text("BMI Pro Medical"),
        backgroundColor: bgBlue,
        foregroundColor: primaryBlue,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline, color: primaryBlue),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Colors.white,
                  surfaceTintColor: Colors.white,
                  title: Text("Tim Pengembang", style: TextStyle(color: primaryBlue, fontWeight: FontWeight.bold)),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildMember("Muhammad Yazid Lubis", "24060123140170"),
                        const Divider(height: 20),
                        _buildMember("Oliver Gunawan M. Sihaloho", "24060123130078"),
                        const Divider(height: 20),
                        _buildMember("Muhammad Kievlan Hakim", "24060123140184"),
                        const SizedBox(height: 20),
                        Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(color: bgBlue, borderRadius: BorderRadius.circular(10)),
                            child: Text("Prodi Informatika", style: TextStyle(color: primaryBlue, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Tutup"))],
                ),
              );
            },
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(color: bgBlue, shape: BoxShape.circle),
                child: Icon(Icons.health_and_safety, size: 80, color: primaryBlue),
              ),
              const SizedBox(height: 20),
              Text(
                "BMI HEALTH CHECK",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: primaryBlue, letterSpacing: 1.5),
              ),
              const Text(
                "Pantau kesehatan tubuh Anda dengan akurat",
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              
              // Tombol Menu
              _buildMenuButton(
                context,
                "Mulai Hitung BMI",
                Icons.calculate,
                primaryBlue,
                Colors.white,
                () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CalculatorScreen())),
              ),
              const SizedBox(height: 15),
              _buildMenuButton(
                context,
                "Panduan & Saran",
                Icons.menu_book,
                bgBlue,
                primaryBlue,
                () => Navigator.push(context, MaterialPageRoute(builder: (context) => const GuideScreen())),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget Helper untuk Menampilkan Nama Anggota
  Widget _buildMember(String nama, String nim) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(nama, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        const SizedBox(height: 4),
        Text("NIM: $nim", style: const TextStyle(color: Colors.grey, fontSize: 13)),
      ],
    );
  }

  Widget _buildMenuButton(BuildContext context, String text, IconData icon, Color bgColor, Color textColor, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: textColor,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: bgColor == Colors.white ? BorderSide(color: textColor) : BorderSide.none,
          ),
        ),
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}