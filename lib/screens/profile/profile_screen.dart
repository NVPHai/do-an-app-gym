import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'workout_schedule_screen.dart';
import 'health_calculator_screen.dart';
import 'reminder_screen.dart';
import '../../services/auth_service.dart';
import '../../services/firestore_service.dart';
import '../../models/user_model.dart';
import 'edit_profile_screen.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Stream<UserModel?> _userStream;
  final authService = AuthService();
  final firestoreService = FirestoreService();
  late final User currentUser;

@override
void initState() {
  super.initState();

  final user = authService.currentUser;

  if (user == null) {
    _userStream = const Stream.empty();
    return;
  }

  currentUser = user;
  _userStream = firestoreService.getUserStream(user.uid);
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D1B2A), Color(0xFF1B263B), Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: StreamBuilder<UserModel?>(
          stream: _userStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: Color(0xFFD4AF37)));
            }

            // Provide default fallback user if not found
            final user = snapshot.data ?? UserModel(
              uid: currentUser.uid,
              email: currentUser.email ?? '',
              name: 'Người dùng',
            );

            return CustomScrollView(
              slivers: [
                /// HEADER & PROFILE INFO
                SliverToBoxAdapter(
                  child: _ProfileImageHeader(user: user),
                ),
                
                SliverToBoxAdapter(
                  child: const SizedBox(height: 60),
                ),

                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Text(
                        user.name.isEmpty ? 'Chưa cập nhật tên' : user.name,
                        style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        user.email,
                        style: const TextStyle(color: Colors.white54, fontSize: 14),
                      ),
                      const SizedBox(height: 20),

                      // Info Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatItem("Tuổi", user.age > 0 ? '${user.age}' : '--'),
                          _buildStatItem("Cân nặng", user.weight > 0 ? '${user.weight} kg' : '--'),
                          _buildStatItem("Chiều cao", user.height > 0 ? '${user.height} cm' : '--'),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Edit Button
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => EditProfileScreen(user: user)),
                          );
                        },
                        icon: const Icon(Icons.edit, color: Colors.black, size: 18),
                        label: const Text("Chỉnh sửa hồ sơ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD4AF37),
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),

                /// TIỆN ÍCH LIST
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      const Text(
                        "TIỆN ÍCH",
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                      ),
                      const SizedBox(height: 15),

                      _buildLuxuryCard(
                        context,
                        title: "Lên lịch tập",
                        subtitle: "Sắp xếp lộ trình tuần",
                        icon: Icons.calendar_month,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const WorkoutScheduleScreen()));
                        },
                      ),

                      _buildLuxuryCard(
                        context,
                        title: "Health & Calories",
                        subtitle: "Tính BMI & calo",
                        icon: Icons.analytics,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const HealthCalculatorScreen()));
                        },
                      ),

                      _buildLuxuryCard(
                        context,
                        title: "Reminder",
                        subtitle: "Nhắc bạn đi tập",
                        icon: Icons.notifications_active,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const ReminderScreen()));
                        },
                      ),

                      _buildLuxuryCard(
                        context,
                        title: "Đăng xuất",
                        subtitle: "Rời khỏi tài khoản",
                        icon: Icons.logout_rounded,
                        onTap: () async {
                          await authService.signOut();
                        },
                      ),
                      const SizedBox(height: 40),
                    ]),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 13)),
      ],
    );
  }

  ///  CARD 
  Widget _buildLuxuryCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFD4AF37),
                    ),
                    child: Icon(icon, color: Colors.black),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          subtitle,
                          style: const TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white54,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileImageHeader extends StatefulWidget {
  final UserModel user;
  const _ProfileImageHeader({required this.user});

  @override
  State<_ProfileImageHeader> createState() => _ProfileImageHeaderState();
}

class _ProfileImageHeaderState extends State<_ProfileImageHeader> {
  late Future<String> _bgPathFuture;
  late Future<String> _avatarPathFuture;
  final _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _bgPathFuture = _firestoreService.getLocalImagePath(widget.user.backgroundUrl);
    _avatarPathFuture = _firestoreService.getLocalImagePath(widget.user.photoUrl);
  }

  @override
  void didUpdateWidget(covariant _ProfileImageHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.user.backgroundUrl != widget.user.backgroundUrl) {
      _bgPathFuture = _firestoreService.getLocalImagePath(widget.user.backgroundUrl);
    }
    if (oldWidget.user.photoUrl != widget.user.photoUrl) {
      _avatarPathFuture = _firestoreService.getLocalImagePath(widget.user.photoUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        // Background Image
        FutureBuilder<String>(
          future: _bgPathFuture,
          builder: (context, bgSnapshot) {
            String bgPath = bgSnapshot.data ?? '';
            return Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white10,
                image: bgPath.isNotEmpty
                    ? DecorationImage(image: FileImage(File(bgPath)), fit: BoxFit.cover)
                    : null,
              ),
              child: bgPath.isEmpty
                  ? const Center(child: Icon(Icons.image, color: Colors.white24, size: 50))
                  : null,
            );
          }
        ),
        
        // Avatar
        Positioned(
          bottom: -50,
          child: FutureBuilder<String>(
            future: _avatarPathFuture,
            builder: (context, avatarSnapshot) {
              String avatarPath = avatarSnapshot.data ?? '';
              return Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF0D1B2A), width: 4),
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.black,
                  backgroundImage: avatarPath.isNotEmpty
                      ? FileImage(File(avatarPath))
                      : null,
                  child: avatarPath.isEmpty
                      ? const Icon(Icons.person, color: Colors.white54, size: 40)
                      : null,
                ),
              );
            }
          ),
        ),
      ],
    );
  }
}