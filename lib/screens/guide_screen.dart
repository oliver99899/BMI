import 'package:flutter/material.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = Colors.blue.shade900;
    final Color headerBlue = Colors.blue.shade50;
    final Color borderBlue = Colors.blue.shade200;

    return Scaffold(
      backgroundColor: Colors.white, // <--- BACKGROUND PUTIH
      appBar: AppBar(title: const Text("Panduan & Saran"), backgroundColor: Colors.blue.shade100, foregroundColor: primaryBlue, surfaceTintColor: Colors.transparent),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSectionTitle("Panduan Penggunaan", Icons.touch_app, primaryBlue),
            Card(
              elevation: 2,
              color: Colors.white, // Kartu Putih
              surfaceTintColor: Colors.white,
              shape: RoundedRectangleBorder(side: BorderSide(color: borderBlue), borderRadius: BorderRadius.circular(8)),
              child: Padding(padding: const EdgeInsets.all(16.0), child: Column(children: [_buildStep(1, "Pilih Satuan", "Gunakan tab di atas untuk memilih Metric (cm/kg) atau US Units (ft/lbs)."), const Divider(), _buildStep(2, "Lengkapi Data", "Masukkan Umur, Gender, Tinggi, dan Berat Badan dengan akurat."), const Divider(), _buildStep(3, "Lihat Analisa", "Tekan tombol Hitung. Aplikasi akan menghitung BMI dan Berat Ideal Anda.")])),
            ),
            const SizedBox(height: 30),
            _buildSectionTitle("1. Tabel BMI Dewasa (WHO)", Icons.person, primaryBlue),
            const Text("Standar untuk usia 20 tahun ke atas.", style: TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic)),
            const SizedBox(height: 10),
            Container(width: double.infinity, decoration: BoxDecoration(border: Border.all(color: borderBlue), borderRadius: BorderRadius.circular(8)), child: ClipRRect(borderRadius: BorderRadius.circular(8), child: DataTable(headingRowColor: MaterialStateProperty.all(headerBlue), dataRowMinHeight: 45, columnSpacing: 20, border: TableBorder(horizontalInside: BorderSide(color: borderBlue, width: 0.5), verticalInside: BorderSide(color: borderBlue, width: 0.5)), columns: const [DataColumn(label: Text('Klasifikasi', style: TextStyle(fontWeight: FontWeight.bold))), DataColumn(label: Text('BMI (kg/m²)', style: TextStyle(fontWeight: FontWeight.bold)))], rows: [_buildRow('Kurus Sekali', '< 16', Colors.white), _buildRow('Kurus Sedang', '16 - 17', Colors.white), _buildRow('Kurus Ringan', '17 - 18.5', Colors.white), _buildRow('Normal', '18.5 - 25', Colors.green.shade50, isBold: true), _buildRow('Gemuk', '25 - 30', Colors.white), _buildRow('Obesitas I', '30 - 35', Colors.white), _buildRow('Obesitas II', '35 - 40', Colors.white), _buildRow('Obesitas III', '> 40', Colors.red.shade50)]))),
            const SizedBox(height: 30),
            _buildSectionTitle("2. Tabel Anak & Remaja (CDC)", Icons.child_care, primaryBlue),
            const Text("Standar persentil untuk usia 2 - 20 tahun.", style: TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic)),
            const SizedBox(height: 10),
            Container(width: double.infinity, decoration: BoxDecoration(border: Border.all(color: borderBlue), borderRadius: BorderRadius.circular(8)), child: ClipRRect(borderRadius: BorderRadius.circular(8), child: DataTable(headingRowColor: MaterialStateProperty.all(headerBlue), dataRowMinHeight: 45, border: TableBorder(horizontalInside: BorderSide(color: borderBlue, width: 0.5), verticalInside: BorderSide(color: borderBlue, width: 0.5)), columns: const [DataColumn(label: Text('Kategori', style: TextStyle(fontWeight: FontWeight.bold))), DataColumn(label: Text('Persentil', style: TextStyle(fontWeight: FontWeight.bold)))], rows: [_buildRow('Underweight', '< 5%', Colors.white), _buildRow('Healthy Weight', '5% - 85%', Colors.green.shade50, isBold: true), _buildRow('At Risk', '85% - 95%', Colors.white), _buildRow('Overweight', '> 95%', Colors.red.shade50)]))),
            const SizedBox(height: 20),
            Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8), border: Border.all(color: borderBlue)), child: Row(children: [Icon(Icons.info_outline, color: primaryBlue), const SizedBox(width: 10), Expanded(child: Text("Data ini hanya referensi. Konsultasikan dengan dokter untuk diagnosa medis yang akurat.", style: TextStyle(fontSize: 12, color: primaryBlue)))])),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  Widget _buildSectionTitle(String text, IconData icon, Color color) => Padding(padding: const EdgeInsets.only(bottom: 10.0), child: Row(children: [Icon(icon, color: color, size: 28), const SizedBox(width: 10), Text(text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color))]));
  Widget _buildStep(int number, String title, String desc) => Padding(padding: const EdgeInsets.symmetric(vertical: 8.0), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [CircleAvatar(radius: 12, backgroundColor: Colors.blue.shade100, child: Text("$number", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue.shade900))), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), const SizedBox(height: 2), Text(desc, style: const TextStyle(fontSize: 13, color: Colors.black87))]))]));
  DataRow _buildRow(String col1, String col2, Color color, {bool isBold = false}) => DataRow(color: MaterialStateProperty.all(color), cells: [DataCell(Text(col1, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal))), DataCell(Text(col2, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)))]);
}