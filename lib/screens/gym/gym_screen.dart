import 'package:flutter/material.dart';
import 'workout_list_screen.dart';
import '../../widgets/category_luxury_card.dart';


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

          return CategoryLuxuryCard(
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

