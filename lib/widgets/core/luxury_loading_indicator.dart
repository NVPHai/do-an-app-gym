import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class LuxuryLoadingIndicator extends StatelessWidget {
  final Color color;
  
  const LuxuryLoadingIndicator({
    super.key,
    this.color = AppColors.gold,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: color),
    );
  }
}
