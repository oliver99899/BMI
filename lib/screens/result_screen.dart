import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final double nilaiImt;
  final double beratIdealMin;
  final double beratIdealMax;

  const ResultScreen({super.key, required this.nilaiImt, required this.beratIdealMin, required this.beratIdealMax});

  String getStatus() {
    if (nilaiImt < 18.5) return "Kurus (Underweight)";
    if (nilaiImt < 25) return "Normal (Healthy)";
    if (nilaiImt < 30) return "Gemuk (Overweight)";
    return "Obesitas (Obese)";
  }

  Color getStatusColor() {
    if (nilaiImt < 18.5) return Colors.blue;
    if (nilaiImt < 25) return Colors.green;
    if (nilaiImt < 30) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = Colors.blue.shade900;
    
    return Scaffold(
      backgroundColor: Colors.white, // <--- BACKGROUND PUTIH
      appBar: AppBar(title: const Text("Hasil Analisa"), backgroundColor: Colors.blue.shade50, foregroundColor: primaryBlue, surfaceTintColor: Colors.transparent),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Card(
              color: Colors.white, // Kartu Putih
              surfaceTintColor: Colors.white,
              elevation: 4,
              shadowColor: Colors.blue.shade100,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: BorderSide(color: Colors.blue.shade200)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Text("Indeks Massa Tubuh (BMI)", style: TextStyle(color: Colors.grey[600], fontSize: 16)),
                    const SizedBox(height: 10),
                    Text(nilaiImt.toStringAsFixed(1), style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: getStatusColor())),
                    Container(margin: const EdgeInsets.symmetric(vertical: 10), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8), decoration: BoxDecoration(color: getStatusColor().withOpacity(0.1), borderRadius: BorderRadius.circular(20)), child: Text(getStatus(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: getStatusColor()))),
                    const Divider(height: 40),
                    _buildInfoRow(Icons.check_circle_outline, "Rentang Normal", "18.5 - 25.0 kg/m²", Colors.green),
                    const SizedBox(height: 15),
                    _buildInfoRow(Icons.monitor_weight_outlined, "Berat Ideal Anda", "${beratIdealMin.toStringAsFixed(1)} - ${beratIdealMax.toStringAsFixed(1)} kg", primaryBlue),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(width: double.infinity, height: 55, child: OutlinedButton(style: OutlinedButton.styleFrom(side: BorderSide(color: primaryBlue, width: 2), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), onPressed: () => Navigator.pop(context), child: Text("HITUNG ULANG", style: TextStyle(color: primaryBlue, fontSize: 16, fontWeight: FontWeight.bold)))),
          ],
        ),
      ),
    );
  }
  Widget _buildInfoRow(IconData icon, String title, String value, Color color) => Row(children: [Icon(icon, color: color, size: 30), const SizedBox(width: 15), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)), Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87))])]);
}