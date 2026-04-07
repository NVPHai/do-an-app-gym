import 'package:flutter/material.dart';
import 'workout_list_screen.dart';

class GymScreen extends StatelessWidget {
  const GymScreen({super.key});

  final List<Map<String, String>> categories = const [
    {'name': 'NGỰC', 'img': 'assets/images/nguc.jpeg'},
    {'name': 'VAI', 'img': 'assets/images/vai.jpg'},
    {'name': 'LƯNG & XÔ', 'img': 'assets/images/lung.jpg'},
    {'name': 'TAY', 'img': 'assets/images/tay.jpg'},
    {'name': 'CORE', 'img': 'assets/images/bung.jpg'},
    {'name': 'CHÂN', 'img': 'assets/images/chan.jpg'},
    {'name': 'MÔNG', 'img': 'assets/images/mong.jpg'},
    {'name': 'THÂN TRÊN', 'img': 'assets/images/than_tren.jpg'},
    {'name': 'THÂN DƯỚI', 'img': 'assets/images/than_duoi.jpg'},
    {'name': 'TOÀN THÂN', 'img': 'assets/images/toan_than.webp'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.25,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final item = categories[index];

          return _LuxuryCard(
            title: item['name']!,
            image: item['img']!,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WorkoutListScreen(
                    categoryName: item['name']!,
                    categoryImageUrl: item['img']!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _LuxuryCard extends StatefulWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const _LuxuryCard({
    required this.title,
    required this.image,
    required this.onTap,
  });

  @override
  State<_LuxuryCard> createState() => _LuxuryCardState();
}

class _LuxuryCardState extends State<_LuxuryCard> {
  double scale = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => scale = 0.96),
      onTapUp: (_) => setState(() => scale = 1),
      onTapCancel: () => setState(() => scale = 1),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 150),
        scale: scale,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Stack(
            children: [
              
              Positioned.fill(
                child: Image.asset(
                  widget.image,
                  fit: BoxFit.cover,
                ),
              ),

              Positioned(
                left: 14,
                bottom: 14,
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
              ),

              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}