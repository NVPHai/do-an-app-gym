import 'package:flutter/material.dart';
import 'cardio_detail_screen.dart';

class CardioScreen extends StatelessWidget {
  const CardioScreen({super.key});

  // Dữ liệu danh sách bài tập Cardio
  static const List<Map<String, dynamic>> cardioWorkouts = [
    {
      'title': 'Jumping Jacks',
      'media': 'assets/videos/cardio_1.gif',
      'duration': 30,
      'time': '30 giây',
      'kcal': '15 kcal',
      'level': 'Dễ',
      'steps': [
        'Đứng thẳng, hai chân khép lại, tay đặt hai bên hông.',
        'Bật nhảy chân sang hai bên đồng thời giơ hai tay lên cao quá đầu.',
        'Bật nhảy trở lại tư thế ban đầu và lặp lại liên tục.',
      ],
    },
    {
      'title': 'High Knees',
      'media': 'assets/videos/cardio_2.gif',
      'duration': 30,
      'time': '30 giây',
      'kcal': '20 kcal',
      'level': 'Trung bình',
      'steps': [
        'Đứng thẳng, hai chân rộng bằng hông.',
        'Chạy tại chỗ bằng cách đưa đầu gối lên cao nhất có thể (ngang hông).',
        'Đánh tay nhịp nhàng và giữ lưng thẳng.',
      ],
    },
    {
      'title': 'Burpees',
      'media': 'assets/videos/cardio_3.gif',
      'duration': 30,
      'time': '30 giây',
      'kcal': '35 kcal',
      'level': 'Khó',
      'steps': [
        'Từ tư thế đứng, hạ người xuống tư thế hít đất.',
        'Bật hai chân ra sau, thực hiện một cái hít đất (tùy chọn).',
        'Bật chân về phía trước và nhảy cao hết mức có thể.',
      ],
    },
    {
      'title': 'Mountain Climbers',
      'media': 'assets/videos/cardio_4.gif',
      'duration': 30,
      'time': '30 giây',
      'kcal': '25 kcal',
      'level': 'Trung bình',
      'steps': [
        'Bắt đầu ở tư thế Plank cao (chống tay thẳng).',
        'Kéo đầu gối trái về phía ngực, sau đó đổi sang chân phải.',
        'Thực hiện nhanh và liên tục như đang leo núi.',
      ],
    },
    {
      'title': 'Jump Squats',
      'media': 'assets/videos/cardio_5.gif',
      'duration': 30,
      'time': '30 giây',
      'kcal': '28 kcal',
      'level': 'Khó',
      'steps': [
        'Hạ người xuống tư thế Squat cho đến khi đùi song song sàn.',
        'Dùng lực gót chân bật nhảy thật mạnh lên cao.',
        'Tiếp đất nhẹ nhàng bằng mũi chân và tiếp tục lần tiếp theo.',
      ],
    },
    {
      'title': 'Butt Kicks',
      'media': 'assets/videos/cardio_6.gif',
      'duration': 30,
      'time': '30 giây',
      'kcal': '15 kcal',
      'level': 'Dễ',
      'steps': [
        'Đứng thẳng, hai chân rộng bằng hông.',
        'Chạy tại chỗ và đá gót chân ra sau sao cho chạm vào mông.',
        'Giữ thân trên ổn định và thực hiện với tốc độ nhanh.',
      ],
    },
    {
      'title': 'Skater Jump',
      'media': 'assets/videos/cardio_7.mp4',
      'duration': 45,
      'time': '45 giây',
      'kcal': '40 kcal',
      'level': 'Khó',
      'steps': [
        'Nhảy sang trái bằng chân trái, đưa chân phải ra sau chân trái.',
        'Nhảy ngược lại sang phải bằng chân phải.',
        'Đánh tay như đang trượt băng tốc độ.',
      ],
    },
    {
      'title': 'Plank Jack',
      'media': 'assets/videos/cardio_8.gif',
      'duration': 30,
      'time': '30 giây',
      'kcal': '18 kcal',
      'level': 'Trung bình',
      'steps': [
        'Ở tư thế Plank trên khuỷu tay hoặc bàn tay.',
        'Bật nhảy hai chân sang hai bên rồi bật khép lại.',
        'Giữ hông cố định, không để mông bị nhô lên cao.',
      ],
    },
    {
      'title': 'Jump Rope',
      'media': 'assets/videos/cardio_9.gif',
      'duration': 60,
      'time': '60 giây',
      'kcal': '50 kcal',
      'level': 'Trung bình',
      'steps': [
        'Giả lập động tác nhảy dây (hoặc dùng dây thật).',
        'Nhảy nhẹ nhàng trên mũi chân.',
        'Xoay cổ tay nhịp nhàng theo từng nhịp nhảy.',
      ],
    },
    {
      'title': 'Running in Place',
      'media': 'assets/videos/cardio_10.gif',
      'duration': 30,
      'time': '30 giây',
      'kcal': '22 kcal',
      'level': 'Dễ',
      'steps': [
        'Chạy tại chỗ với tốc độ trung bình hoặc nhanh.',
        'Nâng cao đùi vừa phải, tiếp đất bằng mũi chân.',
        'Thở đều và đánh tay tự nhiên.',
      ],
    },
  ];

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: CustomScrollView(
        slivers: [

          ///  HEADER
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'CARDIO',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/cardio_header.png',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: Colors.black.withValues(alpha: 0.5),
                  ),
                ],
              ),
            ),
          ),

          ///  LIST
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final item = cardioWorkouts[index];
                return _buildLuxuryCard(context, item);
              }, childCount: cardioWorkouts.length),
            ),
          ),
        ],
      ),
    );
  }

  ///  CARD 
  Widget _buildLuxuryCard(BuildContext context, Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CardioDetailScreen(workout: item),
          ),
        );
      },
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

              ///  BACKGROUND 
              Positioned.fill(
                child: Image.asset(
                  item['media'],
                  fit: BoxFit.cover,
                ),
              ),

              ///  OVERLAY
              Positioned.fill(
                child: Container(
                  color: Colors.black.withValues(alpha: 0.6),
                ),
              ),

              ///  CONTENT
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// TITLE
                    Text(
                      item['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Spacer(),

                    /// CHIPS
                    Row(
                      children: [
                        _chip(item['time'], Icons.timer),
                        const SizedBox(width: 8),
                        _chip(item['kcal'], Icons.local_fire_department),
                        const SizedBox(width: 8),
                        _chip(item['level'], Icons.speed),
                      ],
                    ),
                  ],
                ),
              ),

              /// PLAY ICON
              const Positioned(
                right: 15,
                bottom: 15,
                child: Icon(
                  Icons.play_circle_fill,
                  color: Color(0xFFD4AF37),
                  size: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///  CHIP
  Widget _chip(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.white70),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
