  import 'package:flutter/material.dart';
  import 'package:fitness_pro_max_luxury/screens/auth/auth_gate.dart'; 
  import 'dart:ui';


  class OnboardingScreen extends StatefulWidget {
    const OnboardingScreen({super.key});

    @override
    State<OnboardingScreen> createState() => _OnboardingScreenState();
  }

  class _OnboardingScreenState extends State<OnboardingScreen> {
    final PageController _controller = PageController();
    int _currentIndex = 0;

    final List<Map<String, String>> _data = [
      {
        "title": "Train Anywhere",
        "desc": "Workout anytime that fits your lifestyle.",
        "image": "assets/images/onboarding_1.png",
      },
      {
        "title": "Perfect Technique",
        "desc": "Programs built by top fitness experts.",
        "image": "assets/images/onboarding_2.png",
      },
      {
        "title": "Stay Strong",
        "desc": "Build energy and a powerful body.",
        "image": "assets/images/onboarding_3.png",
      },
    ];

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0D1B2A),
                Color(0xFF1B263B),
                Colors.black,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            children: [
              ///  PAGE VIEW
              PageView.builder(
                controller: _controller,
                itemCount: _data.length,
                onPageChanged: (index) =>
                    setState(() => _currentIndex = index),
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      double value = 1;
                      if (_controller.position.haveDimensions) {
                        value = _controller.page! - index;
                        value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                      }

                      return Transform.scale(
                        scale: value,
                        child: child,
                      );
                    },
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            _data[index]["image"]!,
                            fit: BoxFit.cover,
                          ),
                        ),

                        ///  OVERLAY
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.center,
                                colors: [
                                  Colors.black.withValues(alpha: 0.85),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),

                        ///  TEXT
                        Positioned(
                          left: 24,
                          right: 24,
                          bottom: 140,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _data[index]["title"]!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                _data[index]["desc"]!,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              /// 💎 DOT INDICATOR
              Positioned(
                bottom: 90,
                left: 24,
                child: Row(
                  children: List.generate(
                    _data.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.only(right: 6),
                      height: 6,
                      width: _currentIndex == index ? 24 : 6,
                      decoration: BoxDecoration(
                        color: _currentIndex == index
                            ? Colors.white
                            : Colors.white24,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),

              /// 🧊 NEXT BUTTON (GLASS)
              Positioned(
                bottom: 70,
                right: 24,
                child: GestureDetector(
                  onTap: () {
                    if (_currentIndex == _data.length - 1) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AuthGate(),
                        ),
                      );
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOut,
                      );
                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white24),
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              ///  SKIP
              Positioned(
                top: 50,
                right: 20,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AuthGate(),
                      ),
                    );
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(color: Colors.white54),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }