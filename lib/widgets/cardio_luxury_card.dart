import 'package:flutter/material.dart';
import 'theme/app_colors.dart';
import 'core/luxury_chip.dart';

class CardioLuxuryCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onTap;

  const CardioLuxuryCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  item['media'],
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(
                  color: Colors.black.withValues(alpha: 0.6),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        LuxuryChip(label: item['time'], icon: Icons.timer),
                        const SizedBox(width: 8),
                        LuxuryChip(label: item['kcal'], icon: Icons.local_fire_department),
                        const SizedBox(width: 8),
                        LuxuryChip(label: item['level'], icon: Icons.speed),
                      ],
                    ),
                  ],
                ),
              ),
              const Positioned(
                right: 15,
                bottom: 15,
                child: Icon(
                  Icons.play_circle_fill,
                  color: AppColors.gold,
                  size: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
