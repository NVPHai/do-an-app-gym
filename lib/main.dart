import 'package:fitness_pro_max_luxury/screens/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitness_pro_max_luxury/screens/profile/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init(); 
  runApp(const FitnessApp());
}

class FitnessApp extends StatelessWidget {
  const FitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness App',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const OnboardingScreen(),
    );
  }
}
