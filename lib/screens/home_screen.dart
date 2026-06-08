import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import 'cardio/cardio_screen.dart';
import 'profile/profile_screen.dart';
import 'gym/gym_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  late Stream<UserModel?> _userStream;

  final List<Widget> _screens = [
    const GymScreen(),
    const CardioScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    final authService = AuthService();
    final firestoreService = FirestoreService();
    final currentUser = authService.currentUser;
    if (currentUser != null) {
      _userStream = firestoreService.getUserStream(currentUser.uid);
    } else {
      _userStream = const Stream.empty();
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,

      ///  BODY
      body: Stack(
        children: [

          ///  GRADIENT NỀN
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0D1B2A),
                  Color(0xFF1B263B),
                  Color(0xFF000000),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [

                ///  APPBAR
                StreamBuilder<UserModel?>(
                  stream: _userStream,
                  builder: (context, snapshot) {
                    final user = snapshot.data;
                    String name = user?.name ?? 'Người dùng';
                    if (name.isEmpty) name = 'Người dùng';
                    
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          /// AVATAR
                          _LocalAvatarWidget(photoUrl: user?.photoUrl ?? ''),

                          const SizedBox(width: 12),

                          /// TEXT
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Welcome back",
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                          const Spacer(),
                        ],
                      ),
                    );
                  }
                ),
                ///  SCREEN CONTENT
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(
                          scale: animation,
                          child: child,
                        ),
                      );
                    },
                    child: _screens[_selectedIndex],
                  ),
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),

      /// BOTTOM BAR 
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.4), 
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: GNav(
                  rippleColor: Colors.white24,
                  hoverColor: Colors.white10,
                  gap: 8,
                  iconSize: 24,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: const Duration(milliseconds: 400),


                  color: Colors.white60,
                  activeColor: const Color(0xFFD4AF37), 
                  tabBackgroundColor: Colors.white.withValues(alpha: 0.1),

                  tabs: const [
                    GButton(
                      icon: Icons.fitness_center_rounded,
                      text: 'Gym',
                    ),
                    GButton(
                      icon: Icons.directions_run_rounded,
                      text: 'Cardio',
                    ),
                    GButton(
                      icon: Icons.grid_view_rounded,
                      text: 'Tools',
                    ),
                  ],

                  selectedIndex: _selectedIndex,
                  onTabChange: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LocalAvatarWidget extends StatefulWidget {
  final String photoUrl;
  const _LocalAvatarWidget({required this.photoUrl});

  @override
  State<_LocalAvatarWidget> createState() => _LocalAvatarWidgetState();
}

class _LocalAvatarWidgetState extends State<_LocalAvatarWidget> {
  late Future<String> _imagePathFuture;
  final _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _imagePathFuture = _firestoreService.getLocalImagePath(widget.photoUrl);
  }

  @override
  void didUpdateWidget(covariant _LocalAvatarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.photoUrl != widget.photoUrl) {
      _imagePathFuture = _firestoreService.getLocalImagePath(widget.photoUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _imagePathFuture,
      builder: (context, avatarSnapshot) {
        String avatarPath = avatarSnapshot.data ?? '';
        return CircleAvatar(
          radius: 22,
          backgroundColor: Colors.white10,
          backgroundImage: avatarPath.isNotEmpty ? FileImage(File(avatarPath)) : null,
          child: avatarPath.isEmpty ? const Icon(Icons.person, color: Colors.white54, size: 20) : null,
        );
      },
    );
  }
}