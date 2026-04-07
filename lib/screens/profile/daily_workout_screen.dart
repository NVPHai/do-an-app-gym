import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

// ================= MODEL =================
class ExerciseModel {
  String name;
  String sets;
  String reps;
  String kg;
  bool isDone;

  ExerciseModel({
    required this.name,
    this.sets = "3",
    this.reps = "12",
    this.kg = "0",
    this.isDone = false,
  });

  Map<String, dynamic> toMap() => {
        'name': name,
        'sets': sets,
        'reps': reps,
        'kg': kg,
        'isDone': isDone,
      };

  factory ExerciseModel.fromMap(Map<String, dynamic> map) {
    return ExerciseModel(
      name: map['name'],
      sets: map['sets'],
      reps: map['reps'],
      kg: map['kg'],
      isDone: map['isDone'],
    );
  }
}

class DailyWorkoutScreen extends StatefulWidget {
  final String day;
  const DailyWorkoutScreen({super.key, required this.day});

  @override
  State<DailyWorkoutScreen> createState() => _DailyWorkoutScreenState();
}

class _DailyWorkoutScreenState extends State<DailyWorkoutScreen> {
  List<ExerciseModel> exercises = [];

  //  DATA 
  final Map<String, List<String>> exerciseBank = {
    "NGỰC": [
      "Barbell Bench Press",
      "Dumbbell Bench Press",
      "Incline Bench Press",
      "Decline Bench Press",
      "Dumbbell Fly",
      "Cable Fly",
      "Push-Up",
      "Chest Dips",
      "Machine Chest Press",
      "Pec Deck Machine",
    ],
    "VAI": [
      "Barbell Overhead Press",
      "Dumbbell Shoulder Press",
      "Arnold Press",
      "Lateral Raise",
      "Front Raise",
      "Rear Delt Fly",
      "Face Pull",
      "Upright Row",
      "Cable Lateral Raise",
      "Machine Shoulder Press",
    ],
    "LƯNG": [
      "Pull-Up",
      "Deadlift",
      "Lat Pulldown",
      "Barbell Row",
      "Dumbbell Row",
      "Seated Cable Row",
      "T-Bar Row",
      "Straight Arm Pulldown",
      "Back Extension",
    ],
    "TAY": [
      "Barbell Curl",
      "Dumbbell Curl",
      "Hammer Curl",
      "Preacher Curl",
      "Triceps Dips",
      "Triceps Pushdown",
      "Skull Crusher",
      "Overhead Triceps Extension",
    ],
    "CORE": [
      "Crunch",
      "Plank",
      "Leg Raise",
      "Russian Twist",
      "Ab Wheel Rollout",
      "Bicycle Crunch",
      "V-Ups",
      "Flutter Kicks",
    ],
    "CHÂN": [
      "Barbell Squat",
      "Leg Press",
      "Hack Squat",
      "Romanian Deadlift",
      "Leg Extension",
      "Leg Curl",
      "Bulgarian Split Squat",
      "Standing Calf Raise",
    ],
  };

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonStr = prefs.getString('workout_${widget.day}');

    if (jsonStr != null) {
      List<dynamic> jsonData = jsonDecode(jsonStr);
      setState(() {
        exercises =
            jsonData.map((item) => ExerciseModel.fromMap(item)).toList();
      });
    }
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    String jsonStr =
        jsonEncode(exercises.map((e) => e.toMap()).toList());
    await prefs.setString('workout_${widget.day}', jsonStr);
  }

  // ================= ADD FLOW =================

  void _addNewExercise() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1B263B),
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: exerciseBank.keys.map((group) {
            return ListTile(
              title: Text(
                group,
                style: const TextStyle(color: Colors.white),
              ),
              trailing:
                  const Icon(Icons.arrow_forward_ios, color: Colors.white54),
              onTap: () {
                Navigator.pop(context);
                _showExerciseSelector(group);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showExerciseSelector(String group) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFF0D1B2A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: exerciseBank[group]!.map((ex) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                title: Text(
                  ex,
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _showStatsInput(ex);
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showStatsInput(String name) {
    final setC = TextEditingController(text: "3");
    final repC = TextEditingController(text: "12");
    final kgC = TextEditingController(text: "0");

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: setC, decoration: const InputDecoration(labelText: "Sets")),
            TextField(controller: repC, decoration: const InputDecoration(labelText: "Reps")),
            TextField(controller: kgC, decoration: const InputDecoration(labelText: "Kg")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Hủy")),
          ElevatedButton(
            onPressed: () {
              setState(() {
                exercises.add(
                  ExerciseModel(
                    name: name,
                    sets: setC.text,
                    reps: repC.text,
                    kg: kgC.text,
                  ),
                );
              });
              _saveData();
              Navigator.pop(context);
            },
            child: const Text("Thêm"),
          ),
        ],
      ),
    );
  }

  // ================= UI =================

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
          child: Column(
            children: [

              /// HEADER
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          widget.day,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, color: Colors.white),
                      onPressed: _addNewExercise,
                    ),
                  ],
                ),
              ),

              /// LIST
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: exercises.length,
                  itemBuilder: (context, index) =>
                      _buildCard(exercises[index], index),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(ExerciseModel item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        style: TextStyle(
                          color: item.isDone ? Colors.grey : Colors.white,
                          decoration: item.isDone
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () {
                        setState(() => exercises.removeAt(index));
                        _saveData();
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _stat("Sets", item.sets),
                    _stat("Reps", item.reps),
                    _stat("Kg", item.kg),
                  ],
                ),

                Row(
                  children: [
                    Checkbox(
                      value: item.isDone,
                      activeColor: const Color(0xFFD4AF37),
                      onChanged: (val) {
                        setState(() => item.isDone = val!);
                        _saveData();
                      },
                    ),
                    const Text("Done", style: TextStyle(color: Colors.white70))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _stat(String t, String v) {
    return Column(
      children: [
        Text(t, style: const TextStyle(color: Colors.white54)),
        Text(v,
            style: const TextStyle(
              color: Color(0xFFD4AF37),
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }
}