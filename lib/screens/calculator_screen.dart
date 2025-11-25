import 'package:flutter/material.dart';
import 'result_screen.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController kontrolTinggiCm = TextEditingController();
  final TextEditingController kontrolBeratKg = TextEditingController();
  final TextEditingController kontrolTinggiFt = TextEditingController();
  final TextEditingController kontrolTinggiIn = TextEditingController();
  final TextEditingController kontrolBeratLbs = TextEditingController();
  final TextEditingController kontrolUmur = TextEditingController();
  int selectedGender = 0; 
  bool isMetric = true;
  final Color primaryBlue = Colors.blue.shade900;
  final Color bgBlue = Colors.blue.shade50;
  final Color borderBlue = Colors.blue.shade200;

  void hitungIMT() {
    if (kontrolUmur.text.isEmpty) { showError("Mohon isi Umur Anda"); return; }
    double tinggiMeter = 0;
    double beratKg = 0;
    if (isMetric) {
      if (kontrolTinggiCm.text.isEmpty || kontrolBeratKg.text.isEmpty) { showError("Lengkapi data Tinggi & Berat"); return; }
      tinggiMeter = double.parse(kontrolTinggiCm.text) / 100;
      beratKg = double.parse(kontrolBeratKg.text);
    } else {
      if (kontrolTinggiFt.text.isEmpty || kontrolTinggiIn.text.isEmpty || kontrolBeratLbs.text.isEmpty) { showError("Lengkapi data (US Units)"); return; }
      double feet = double.parse(kontrolTinggiFt.text);
      double inches = double.parse(kontrolTinggiIn.text);
      double lbs = double.parse(kontrolBeratLbs.text);
      tinggiMeter = ((feet * 12) + inches) * 0.0254;
      beratKg = lbs * 0.453592;
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => ResultScreen(nilaiImt: beratKg / (tinggiMeter * tinggiMeter), beratIdealMin: 18.5 * (tinggiMeter * tinggiMeter), beratIdealMax: 25.0 * (tinggiMeter * tinggiMeter))));
  }

  void showError(String msg) { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red)); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // <--- BACKGROUND PUTIH
      appBar: AppBar(title: const Text("Kalkulator BMI"), backgroundColor: bgBlue, foregroundColor: primaryBlue, surfaceTintColor: Colors.transparent),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: bgBlue, borderRadius: BorderRadius.circular(10), border: Border.all(color: borderBlue)),
              child: Row(children: [_buildTab("Metric Units", isMetric), _buildTab("US Units", !isMetric)]),
            ),
            const SizedBox(height: 20),
            Card(
              color: Colors.white, // Pastikan kartu juga putih
              surfaceTintColor: Colors.white,
              elevation: 4,
              shadowColor: Colors.blue.shade100,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: BorderSide(color: borderBlue)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _buildInputRow("Umur", "thn", kontrolUmur),
                    const SizedBox(height: 15),
                    Row(children: [
                      Expanded(flex: 1, child: Text("Gender", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primaryBlue))),
                      Expanded(flex: 2, child: Row(children: [_buildGenderBtn("Pria", 0), const SizedBox(width: 10), _buildGenderBtn("Wanita", 1)])),
                    ]),
                    const SizedBox(height: 15),
                    if (isMetric) ...[
                      _buildInputRow("Tinggi", "cm", kontrolTinggiCm),
                      const SizedBox(height: 15),
                      _buildInputRow("Berat", "kg", kontrolBeratKg),
                    ] else ...[
                      Row(children: [Expanded(flex: 1, child: Text("Tinggi", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primaryBlue))), Expanded(child: _buildTextField(kontrolTinggiFt, "feet")), const SizedBox(width: 10), Expanded(child: _buildTextField(kontrolTinggiIn, "inches"))]),
                      const SizedBox(height: 15),
                      _buildInputRow("Berat", "lbs", kontrolBeratLbs),
                    ],
                    const SizedBox(height: 30),
                    SizedBox(width: double.infinity, height: 55, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: primaryBlue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), onPressed: hitungIMT, child: const Text("ANALISA KESEHATAN", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Widget Helpers (Tab, InputRow, TextField, GenderBtn) tetap sama, hanya disingkat di sini biar muat
  Widget _buildTab(String text, bool isActive) => Expanded(child: GestureDetector(onTap: () => setState(() => isMetric = text == "Metric Units"), child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: isActive ? primaryBlue : Colors.transparent, borderRadius: BorderRadius.circular(8)), child: Text(text, textAlign: TextAlign.center, style: TextStyle(color: isActive ? Colors.white : primaryBlue, fontWeight: FontWeight.bold)))));
  Widget _buildInputRow(String label, String unit, TextEditingController controller) => Row(children: [Expanded(flex: 1, child: Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primaryBlue))), Expanded(flex: 2, child: _buildTextField(controller, unit)), const SizedBox(width: 10), Text(unit, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey))]);
  Widget _buildTextField(TextEditingController controller, String hint) => TextField(controller: controller, keyboardType: TextInputType.number, style: TextStyle(color: primaryBlue, fontWeight: FontWeight.bold), decoration: InputDecoration(isDense: true, hintText: hint, filled: true, fillColor: Colors.blue.shade50, border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none)));
  Widget _buildGenderBtn(String label, int val) { bool isSelected = selectedGender == val; return GestureDetector(onTap: () => setState(() => selectedGender = val), child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: isSelected ? primaryBlue : Colors.blue.shade50, borderRadius: BorderRadius.circular(20), border: Border.all(color: isSelected ? primaryBlue : borderBlue)), child: Text(label, style: TextStyle(color: isSelected ? Colors.white : primaryBlue, fontWeight: FontWeight.bold)))); }
}