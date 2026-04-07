import 'package:flutter/material.dart';
import 'dart:ui';

class HealthCalculatorScreen extends StatefulWidget {
  const HealthCalculatorScreen({super.key});

  @override
  State<HealthCalculatorScreen> createState() =>
      _HealthCalculatorScreenState();
}

class _HealthCalculatorScreenState extends State<HealthCalculatorScreen> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _ageController = TextEditingController();

  double _bmi = 0;
  double _tdee = 0;
  String _activityLevel = '1.2';

  void _calculate() {
    double w = double.tryParse(_weightController.text) ?? 0;
    double h = double.tryParse(_heightController.text) ?? 0;
    int a = int.tryParse(_ageController.text) ?? 0;
    double activity = double.parse(_activityLevel);

    if (w > 0 && h > 0 && a > 0) {
      setState(() {
        _bmi = w / ((h / 100) * (h / 100));
        double bmr = (10 * w) + (6.25 * h) - (5 * a) + 5;
        _tdee = bmr * activity;
      });
    }
  }

  String _getBMIStatus(double bmi) {
    if (bmi < 18.5) return "Gầy";
    if (bmi < 25) return "Chuẩn";
    if (bmi < 30) return "Hơi mập";
    return "Béo";
  }

  Color _getColor(double bmi) {
    if (bmi < 18.5) return Colors.orange;
    if (bmi < 25) return Colors.green;
    if (bmi < 30) return Colors.deepOrange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0D1B2A),
              Color(0xFF1B263B),
              Colors.black,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _header(),
                const SizedBox(height: 20),
                _inputCard(),
                const SizedBox(height: 20),
                if (_bmi > 0) _resultCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        const Expanded(
          child: Center(
            child: Text(
              "HEALTH CALCULATOR",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 40),
      ],
    );
  }

  Widget _inputCard() {
    return _glassContainer(
      child: Column(
        children: [
          _input(_ageController, "Tuổi"),
          _input(_weightController, "Cân nặng (kg)"),
          _input(_heightController, "Chiều cao (cm)"),

          const SizedBox(height: 15),

          DropdownButtonFormField<String>(
            dropdownColor: const Color(0xFF1B263B),
            initialValue: _activityLevel,
            style: const TextStyle(color: Colors.white),
            items: const [
              DropdownMenuItem(value: '1.2', child: Text("Ít vận động")),
              DropdownMenuItem(value: '1.375', child: Text("Nhẹ")),
              DropdownMenuItem(value: '1.55', child: Text("Vừa")),
              DropdownMenuItem(value: '1.725', child: Text("Nặng")),
            ],
            onChanged: (val) => setState(() => _activityLevel = val!),
            decoration: const InputDecoration(
              labelText: "Mức độ vận động",
              labelStyle: TextStyle(color: Colors.white70),
            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: _calculate,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD4AF37),
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text("TÍNH NGAY",
                style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  Widget _resultCard() {
    Color c = _getColor(_bmi);

    return Column(
      children: [

        /// STATUS
        _glassContainer(
          child: Column(
            children: [
              const Text("TRẠNG THÁI",
                  style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 10),
              Text(
                _getBMIStatus(_bmi),
                style: TextStyle(
                  fontSize: 28,
                  color: c,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "BMI: ${_bmi.toStringAsFixed(1)}",
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        /// BMI + TDEE
        Row(
          children: [
            _info("BMI", _bmi.toStringAsFixed(1), Colors.blue),
            const SizedBox(width: 10),
            _info("TDEE", "${_tdee.toInt()} kcal", Colors.orange),
          ],
        ),

        const SizedBox(height: 20),

        /// DIET
        _glassContainer(
          child: Column(
            children: [
              const Text("GỢI Ý CALO",
                  style: TextStyle(color: Colors.white)),
              const Divider(color: Colors.white24),
              _diet("Giảm cân", _tdee - 500),
              _diet("Duy trì", _tdee),
              _diet("Tăng cơ", _tdee + 500),
            ],
          ),
        ),
      ],
    );
  }

  Widget _glassContainer({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white10),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _input(TextEditingController c, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: c,
        keyboardType: TextInputType.number,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white24),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFD4AF37)),
          ),
        ),
      ),
    );
  }

  Widget _info(String t, String v, Color c) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: c.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Text(t, style: const TextStyle(color: Colors.white70)),
            Text(
              v,
              style: TextStyle(
                color: c,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _diet(String label, double kcal) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white)),
          Text("${kcal.toInt()} kcal",
              style: const TextStyle(
                  color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}