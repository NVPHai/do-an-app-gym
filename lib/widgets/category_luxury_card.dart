import 'package:flutter/material.dart';

class CategoryLuxuryCard extends StatefulWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const CategoryLuxuryCard({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
  });

  @override
  State<CategoryLuxuryCard> createState() => _CategoryLuxuryCardState();
}

class _CategoryLuxuryCardState extends State<CategoryLuxuryCard> {
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
