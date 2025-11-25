import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas BMI',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const HalamanUtama(),
    );
  }
}

// --- LAYAR 1: INPUT (BERANDA) ---
class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  final TextEditingController kontrolTinggi = TextEditingController();
  final TextEditingController kontrolBerat = TextEditingController();

  void hitungIMT() {
    if (kontrolTinggi.text.isEmpty || kontrolBerat.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mohon isi tinggi dan berat badan!")),
      );
      return;
    }
    double tinggi = double.parse(kontrolTinggi.text) / 100;
    double berat = double.parse(kontrolBerat.text);
    double hasilImt = berat / (tinggi * tinggi);
    
    Navigator.push(context, MaterialPageRoute(builder: (context) => HalamanHasil(nilaiImt: hasilImt)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kalkulator IMT"),
        backgroundColor: Colors.blue[100],
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HalamanTentang()));
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Masukkan Data Anda", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextField(controller: kontrolTinggi, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Tinggi Badan (cm)", border: OutlineInputBorder(), prefixIcon: Icon(Icons.height))),
            const SizedBox(height: 20),
            TextField(controller: kontrolBerat, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Berat Badan (kg)", border: OutlineInputBorder(), prefixIcon: Icon(Icons.monitor_weight))),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity, height: 50,
              child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.blue), onPressed: hitungIMT, child: const Text("HITUNG SEKARANG", style: TextStyle(color: Colors.white))),
            ),
          ],
        ),
      ),
    );
  }
}

// --- LAYAR 2: HASIL ---
class HalamanHasil extends StatelessWidget {
  final double nilaiImt;
  const HalamanHasil({super.key, required this.nilaiImt});

  String getStatus() {
    if (nilaiImt < 18.5) return "Kurus";
    if (nilaiImt < 25) return "Normal";
    if (nilaiImt < 30) return "Gemuk";
    return "Obesitas";
  }

  Color getWarna() {
    if (nilaiImt < 18.5) return Colors.orange;
    if (nilaiImt < 25) return Colors.green;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hasil Perhitungan")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Nilai IMT Anda:", style: TextStyle(fontSize: 20)),
            Text(nilaiImt.toStringAsFixed(1), style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: getWarna())),
            Text(getStatus(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: getWarna())),
            const SizedBox(height: 30),
            ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("Hitung Ulang"))
          ],
        ),
      ),
    );
  }
}

// --- LAYAR 3: TENTANG (ABOUT) ---
class HalamanTentang extends StatelessWidget {
  const HalamanTentang({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tentang Pengembang")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.account_circle, size: 100, color: Colors.blue),
            SizedBox(height: 20),
            Text("Aplikasi Dibuat Oleh:", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("MUHAMMAD YAZID LUBIS", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text("NIM: 24060123140170", style: TextStyle(fontSize: 18, color: Colors.grey)),
            SizedBox(height: 20),
            Text("Prodi Informatika", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}