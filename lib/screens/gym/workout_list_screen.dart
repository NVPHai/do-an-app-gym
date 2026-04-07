import 'package:flutter/material.dart';
import 'exercise_detail_screen.dart';

class WorkoutListScreen extends StatelessWidget {
  final String categoryName;
  final String categoryImageUrl;

  const WorkoutListScreen({
    super.key,
    required this.categoryName,
    required this.categoryImageUrl,
  });

  // --- KHO DỮ LIỆU CẬP NHẬT MỚI ---
  static const Map<String, List<Map<String, dynamic>>> _workoutData = {
    'NGỰC': [
      {
        'title': 'Barbell Bench Press',
        'muscles': ['Ngực', 'Tay sau', 'Vai'],
        'media': 'assets/videos/nguc_1.mp4',
        'steps': [
          'Nằm thẳng trên ghế, hai chân đặt vững trên sàn.',
          'Nắm thanh đòn rộng hơn vai, hạ thanh đòn chậm rãi xuống giữa ngực.',
          'Đẩy mạnh thanh đòn lên cao và thở ra.',
        ],
      },
      {
        'title': 'Dumbbell Bench Press',
        'muscles': ['Ngực', 'Tay sau'],
        'media': 'assets/videos/nguc_2.gif',
        'steps': [
          'Mỗi tay cầm một quả tạ đơn, nằm trên ghế phẳng.',
          'Hạ tạ xuống sao cho khuỷu tay vuông góc.',
          'Ép cơ ngực để đẩy tạ lên cho đến khi hai quả tạ gần chạm nhau.',
        ],
      },
      {
        'title': 'Incline Bench Press',
        'muscles': ['Ngực trên', 'Vai'],
        'media': 'assets/videos/nguc_3.mp4',
        'steps': [
          'Chỉnh ghế dốc lên khoảng 30-45 độ.',
          'Hạ thanh đòn xuống phần ngực trên (gần xương quai xanh).',
          'Đẩy tạ lên tập trung cảm nhận phần cơ ngực phía trên.',
        ],
      },
      {
        'title': 'Decline Bench Press',
        'muscles': ['Ngực dưới', 'Tay sau'],
        'media': 'assets/videos/nguc_4.gif',
        'steps': [
          'Nằm trên ghế dốc xuống, chân móc vào giá đỡ.',
          'Hạ tạ xuống phần ngực dưới.',
          'Đẩy tạ lên và giữ kiểm soát để không bị dồn máu lên đầu quá nhanh.',
        ],
      },
      {
        'title': 'Dumbbell Fly',
        'muscles': ['Ngực'],
        'media': 'assets/videos/nguc_5.gif',
        'steps': [
          'Nằm trên ghế, hai tay cầm tạ giơ thẳng trước ngực.',
          'Mở rộng tay sang hai bên theo hình vòng cung, hơi cong khuỷu tay.',
          'Dùng cơ ngực ép tạ trở lại vị trí ban đầu.',
        ],
      },
      {
        'title': 'Cable Fly',
        'muscles': ['Ngực'],
        'media': 'assets/videos/nguc_6.gif',
        'steps': [
          'Đứng giữa máy kéo cáp, hai tay cầm tay nắm.',
          'Kéo hai tay lại gần nhau trước ngực, giữ khuỷu tay hơi cong.',
          'Kiểm soát lực kéo khi mở tay ra để giãn cơ ngực tối đa.',
        ],
      },
      {
        'title': 'Push-Up',
        'muscles': ['Ngực', 'Tay sau', 'Core'],
        'media': 'assets/videos/nguc_7.mp4',
        'steps': [
          'Vị trí hít đất, tay rộng bằng vai, người thẳng như một đường thẳng.',
          'Hạ người xuống cho đến khi ngực gần chạm sàn.',
          'Đẩy người lên và gồng chặt cơ bụng.',
        ],
      },
      {
        'title': 'Chest Dips',
        'muscles': ['Ngực dưới', 'Tay sau'],
        'media': 'assets/videos/nguc_8.gif',
        'steps': [
          'Chống hai tay lên xà kép, hơi nghiêng người về phía trước.',
          'Hạ người xuống cho đến khi cánh tay và khuỷu tay tạo góc 90 độ.',
          'Dùng cơ ngực đẩy người lên cao.',
        ],
      },
      {
        'title': 'Machine Chest Press',
        'muscles': ['Ngực'],
        'media': 'assets/videos/nguc_9.gif',
        'steps': [
          'Ngồi vào máy, chỉnh ghế sao cho tay cầm ngang ngực.',
          'Đẩy tay cầm ra phía trước cho đến khi tay gần thẳng.',
          'Thu tay về chậm rãi để duy trì áp lực lên cơ ngực.',
        ],
      },
      {
        'title': 'Pec Deck Machine',
        'muscles': ['Ngực'],
        'media': 'assets/videos/nguc_10.gif',
        'steps': [
          'Ngồi vào máy, đặt cẳng tay lên miếng đệm hoặc cầm tay nắm.',
          'Ép hai cánh tay lại gần nhau trước mặt.',
          'Mở rộng ngực hết mức khi đưa tay về vị trí cũ.',
        ],
      },
    ],
    'VAI': [
      {
        'title': 'Barbell Overhead Press',
        'muscles': ['Vai', 'Tay sau'],
        'media': 'assets/videos/vai_1.gif',
        'steps': [
          'Đứng thẳng, hai chân rộng bằng vai, giữ thanh đòn ngang vai trước.',
          'Gồng chặt bụng, đẩy thanh đòn thẳng lên trên đầu.',
          'Hạ thanh đòn xuống chậm rãi về vị trí ngang vai và lặp lại.',
        ],
      },
      {
        'title': 'Dumbbell Shoulder Press',
        'muscles': ['Vai', 'Tay sau'],
        'media': 'assets/videos/vai_2.gif',
        'steps': [
          'Ngồi trên ghế có tựa lưng, mỗi tay cầm một quả tạ đơn đặt ngang tai.',
          'Đẩy tạ lên cao cho đến khi hai cánh tay gần thẳng đứng.',
          'Hạ tạ xuống từ từ sao cho khuỷu tay vuông góc.',
        ],
      },
      {
        'title': 'Arnold Press',
        'muscles': ['Vai trước', 'Vai giữa'],
        'media': 'assets/videos/vai_3.gif',
        'steps': [
          'Cầm tạ đơn trước ngực, lòng bàn tay hướng về phía người.',
          'Vừa đẩy tạ lên vừa xoay cổ tay ra ngoài.',
          'Khi hạ tạ xuống, xoay lòng bàn tay trở lại hướng vào người.',
        ],
      },
      {
        'title': 'Lateral Raise',
        'muscles': ['Vai giữa'],
        'media': 'assets/videos/vai_4.gif',
        'steps': [
          'Đứng thẳng, hai tay cầm tạ đơn đặt bên hông.',
          'Dùng cơ vai nhấc tạ sang hai bên cho đến khi cánh tay song song với sàn.',
          'Hạ tạ xuống chậm để cảm nhận độ căng của cơ vai giữa.',
        ],
      },
      {
        'title': 'Front Raise',
        'muscles': ['Vai trước'],
        'media': 'assets/videos/vai_5.mp4', // Bài này của ní là video nè
        'steps': [
          'Cầm tạ đơn đặt trước đùi, lòng bàn tay hướng vào trong.',
          'Nâng tạ thẳng về phía trước cho đến khi ngang tầm mắt.',
          'Giữ 1 giây ở vị trí cao nhất rồi hạ xuống từ từ.',
        ],
      },
      {
        'title': 'Rear Delt Fly',
        'muscles': ['Vai sau'],
        'media': 'assets/videos/vai_6.gif',
        'steps': [
          'Cúi người về phía trước, lưng phẳng, hai tay cầm tạ buông thõng.',
          'Mở rộng tay sang hai bên như dang cánh, tập trung vào phần vai sau.',
          'Ép xương bả vai lại và từ từ hạ tạ về vị trí ban đầu.',
        ],
      },
      {
        'title': 'Face Pull',
        'muscles': ['Vai sau', 'Lưng trên'],
        'media': 'assets/videos/vai_7.gif',
        'steps': [
          'Sử dụng máy kéo cáp với dây thừng, đặt máy ngang tầm mặt.',
          'Kéo dây thừng về phía trán, tách hai đầu dây sang hai bên tai.',
          'Gồng chặt vai sau rồi thả cáp ra chậm rãi.',
        ],
      },
      {
        'title': 'Upright Row',
        'muscles': ['Vai', 'Cầu vai'],
        'media': 'assets/videos/vai_8.gif',
        'steps': [
          'Cầm thanh đòn hoặc tạ đơn đặt sát đùi.',
          'Kéo tạ thẳng lên dọc theo cơ thể cho đến khi gần chạm cằm.',
          'Khuỷu tay luôn hướng ra ngoài và cao hơn cổ tay.',
        ],
      },
      {
        'title': 'Cable Lateral Raise',
        'muscles': ['Vai giữa'],
        'media': 'assets/videos/vai_9.gif',
        'steps': [
          'Đứng cạnh máy cáp, tay xa máy hơn cầm tay nắm.',
          'Kéo cáp sang ngang và lên cao cho đến khi tay song song với sàn.',
          'Kiểm soát lực kéo của cáp khi thu tay về.',
        ],
      },
      {
        'title': 'Machine Shoulder Press',
        'muscles': ['Vai'],
        'media': 'assets/videos/vai_10.gif',
        'steps': [
          'Ngồi vào máy, điều chỉnh ghế sao cho tay cầm ngang vai.',
          'Đẩy tay cầm lên cao và thở ra.',
          'Hạ xuống chậm rãi để giữ áp lực liên tục lên cơ vai.',
        ],
      },
    ],
    'LƯNG & XÔ': [
      {
        'title': 'Pull-Up',
        'muscles': ['Xô', 'Lưng trên', 'Tay trước'],
        'media': 'assets/videos/lung_1.mp4', // Bài này .mp4 nè
        'steps': [
          'Nắm xà đơn rộng hơn vai, lòng bàn tay hướng về phía trước.',
          'Dùng cơ xô kéo người lên cho đến khi cằm vượt qua thanh xà.',
          'Hạ người xuống chậm rãi cho đến khi tay duỗi thẳng hoàn toàn.',
        ],
      },
      {
        'title': 'Deadlift',
        'muscles': ['Toàn thân', 'Lưng dưới', 'Đùi sau'],
        'media': 'assets/videos/lung_2.mp4', // Bài này .mp4 nè
        'steps': [
          'Đứng trước thanh đòn, hai chân rộng bằng vai, hạ người nắm thanh đòn.',
          'Giữ lưng thẳng, đẩy mạnh chân và kéo thanh đòn lên dọc theo ống chân.',
          'Đứng thẳng người, ưỡn ngực, sau đó hạ tạ xuống có kiểm soát.',
        ],
      },
      {
        'title': 'Lat Pulldown',
        'muscles': ['Xô', 'Lưng trên'],
        'media': 'assets/videos/lung_3.gif',
        'steps': [
          'Ngồi vào máy kéo xô, hai tay nắm thanh cầm rộng hơn vai.',
          'Ưỡn ngực, kéo thanh cầm xuống sát phần ngực trên.',
          'Từ từ thả thanh cầm lên cao để cơ xô được giãn ra tối đa.',
        ],
      },
      {
        'title': 'Barbell Row',
        'muscles': ['Lưng giữa', 'Tay trước'],
        'media': 'assets/videos/lung_4.gif',
        'steps': [
          'Cúi người, giữ lưng thẳng song song với sàn, hai tay cầm thanh đòn.',
          'Kéo thanh đòn về phía bụng dưới, ép chặt xương bả vai.',
          'Hạ tạ xuống chậm rãi và không được để lưng bị cong.',
        ],
      },
      {
        'title': 'Dumbbell Row',
        'muscles': ['Lưng giữa', 'Xô'],
        'media': 'assets/videos/lung_5.gif',
        'steps': [
          'Chống một tay và một đầu gối lên ghế phẳng, tay kia cầm tạ đơn.',
          'Kéo tạ lên sát hông, giữ khuỷu tay sát mạn sườn.',
          'Hạ tạ xuống hết cỡ để cơ lưng được kéo căng.',
        ],
      },
      {
        'title': 'Seated Cable Row',
        'muscles': ['Lưng giữa', 'Xô'],
        'media': 'assets/videos/lung_6.gif',
        'steps': [
          'Ngồi vào máy kéo cáp, hai chân đặt lên giá đỡ, hơi chùng gối.',
          'Kéo tay cầm về phía bụng, giữ lưng thẳng và ưỡn ngực.',
          'Thả tay về phía trước nhưng không được để lưng bị kéo theo.',
        ],
      },
      {
        'title': 'T-Bar Row',
        'muscles': ['Lưng', 'Xô'],
        'media': 'assets/videos/lung_7.gif',
        'steps': [
          'Đứng lên máy T-Bar hoặc thanh đòn kẹp góc tường.',
          'Kéo tạ lên sát bụng, ép chặt phần lưng giữa.',
          'Hạ tạ xuống từ từ, giữ lưng luôn thẳng.',
        ],
      },
      {
        'title': 'Straight Arm Pulldown',
        'muscles': ['Xô'],
        'media': 'assets/videos/lung_8.gif',
        'steps': [
          'Đứng trước máy cáp, hai tay duỗi thẳng nắm thanh cầm.',
          'Dùng cơ xô kéo thanh cầm xuống sát đùi mà không gập khuỷu tay.',
          'Đưa thanh cầm về vị trí cũ thật chậm.',
        ],
      },
      {
        'title': 'Back Extension',
        'muscles': ['Lưng dưới', 'Mông'],
        'media': 'assets/videos/lung_9.gif',
        'steps': [
          'Nằm lên ghế tập lưng dưới, gót chân móc vào giá đỡ.',
          'Gập người xuống, sau đó dùng cơ lưng dưới nâng người lên cho đến khi thẳng hàng với chân.',
          'Lưu ý không ngửa người ra sau quá mức.',
        ],
      },
    ],
    'TAY': [
      {
        'title': 'Barbell Curl',
        'muscles': ['Tay trước'],
        'media': 'assets/videos/tay_1.gif',
        'steps': [
          'Đứng thẳng, hai tay cầm thanh đòn lòng bàn tay hướng ra ngoài.',
          'Cuộn thanh đòn lên phía vai, giữ khuỷu tay sát mạn sườn.',
          'Hạ thanh đòn xuống chậm rãi để cơ tay trước được kéo căng.',
        ],
      },
      {
        'title': 'Dumbbell Curl',
        'muscles': ['Tay trước'],
        'media': 'assets/videos/tay_2.gif',
        'steps': [
          'Mỗi tay cầm một quả tạ đơn, đứng thẳng hoặc ngồi trên ghế.',
          'Xoay lòng bàn tay hướng lên trên khi cuộn tạ lên cao.',
          'Hạ tạ xuống từ từ và tránh dùng đà của cơ thể để lăng tạ.',
        ],
      },
      {
        'title': 'Hammer Curl',
        'muscles': ['Tay trước', 'Cẳng tay'],
        'media': 'assets/videos/tay_3.gif',
        'steps': [
          'Cầm tạ đơn với lòng bàn tay hướng vào nhau (như cầm búa).',
          'Cuộn tạ lên cao trong khi vẫn giữ lòng bàn tay hướng vào nhau.',
          'Động tác này giúp tăng độ dày cho bắp tay và cơ cẳng tay.',
        ],
      },
      {
        'title': 'Preacher Curl',
        'muscles': ['Tay trước'],
        'media': 'assets/videos/tay_4.gif',
        'steps': [
          'Ngồi vào ghế tập tay trước, đặt bắp tay lên miếng đệm.',
          'Cuộn thanh đòn hoặc tạ đơn lên cao, giữ nách sát mép đệm.',
          'Hạ tạ xuống thật chậm, đây là bài tập giúp cô lập cơ tay trước cực tốt.',
        ],
      },
      {
        'title': 'Triceps Dips',
        'muscles': ['Tay sau', 'Ngực'],
        'media': 'assets/videos/tay_5.gif',
        'steps': [
          'Chống hai tay lên ghế hoặc xà kép, chân duỗi thẳng phía trước.',
          'Hạ người xuống bằng cách gập khuỷu tay cho đến khi tay tạo góc 90 độ.',
          'Đẩy mạnh người lên bằng cơ tay sau và thở ra.',
        ],
      },
      {
        'title': 'Triceps Pushdown',
        'muscles': ['Tay sau'],
        'media': 'assets/videos/tay_6.gif',
        'steps': [
          'Đứng trước máy cáp, hai tay cầm thanh ngang hoặc dây thừng.',
          'Gồng cơ tay sau đẩy cáp xuống cho đến khi tay duỗi thẳng hoàn toàn.',
          'Giữ khuỷu tay cố định sát người trong suốt quá trình tập.',
        ],
      },
      {
        'title': 'Skull Crusher',
        'muscles': ['Tay sau'],
        'media': 'assets/videos/tay_7.gif',
        'steps': [
          'Nằm trên ghế phẳng, hai tay cầm thanh đòn EZ giơ thẳng lên trên.',
          'Gập khuỷu tay để hạ thanh đòn về phía trán (không được di chuyển bắp tay).',
          'Dùng cơ tay sau đẩy thanh đòn trở lại vị trí ban đầu.',
        ],
      },
      {
        'title': 'Overhead Triceps Extension',
        'muscles': ['Tay sau'],
        'media': 'assets/videos/tay_8.gif',
        'steps': [
          'Cầm một quả tạ đơn bằng cả hai tay, đưa tạ lên cao quá đầu.',
          'Hạ tạ xuống phía sau gáy bằng cách gập khuỷu tay.',
          'Đẩy tạ thẳng lên trên đầu để hoàn thành một lần lặp.',
        ],
      },
    ],
    'CORE (BỤNG)': [
      {
        'title': 'Crunch',
        'muscles': ['Bụng trên'],
        'media': 'assets/videos/bung_1.gif',
        'steps': [
          'Nằm ngửa, gập đầu gối, hai chân đặt trên sàn.',
          'Đặt tay nhẹ sau đầu, dùng cơ bụng nâng vai lên khỏi sàn khoảng 10cm.',
          'Thở ra khi lên đỉnh và hạ xuống chậm rãi, giữ lưng dưới chạm sàn.',
        ],
      },
      {
        'title': 'Plank',
        'muscles': ['Toàn bộ Core', 'Lưng'],
        'media': 'assets/videos/bung_2.mp4', // Video cho bài giữ tĩnh
        'steps': [
          'Chống hai khuỷu tay vuông góc dưới vai, mũi chân chạm đất.',
          'Giữ cơ thể thành một đường thẳng từ đầu đến gót chân.',
          'Gồng chặt bụng và mông, không để lưng bị võng xuống.',
        ],
      },
      {
        'title': 'Leg Raise',
        'muscles': ['Bụng dưới'],
        'media': 'assets/videos/bung_3.gif',
        'steps': [
          'Nằm ngửa, hai tay đặt dọc theo thân hoặc dưới mông để đỡ lưng.',
          'Giữ chân thẳng, từ từ nâng hai chân lên cho đến khi vuông góc với sàn.',
          'Hạ chân xuống thật chậm nhưng không được để gót chân chạm đất.',
        ],
      },
      {
        'title': 'Russian Twist',
        'muscles': ['Cơ liên sườn', 'Core'],
        'media': 'assets/videos/bung_4.gif',
        'steps': [
          'Ngồi hơi ngả người ra sau, gập gối, có thể nhấc chân khỏi sàn để tăng độ khó.',
          'Đan hai tay trước ngực, xoay toàn bộ thân trên sang trái rồi sang phải.',
          'Tập trung vào việc xoay cơ bụng chứ không chỉ di chuyển cánh tay.',
        ],
      },
      {
        'title': 'Ab Wheel Rollout',
        'muscles': ['Toàn bộ Core', 'Vai'],
        'media': 'assets/videos/bung_5.gif',
        'steps': [
          'Quỳ trên sàn, hai tay cầm con lăn đặt trước mặt.',
          'Lăn bánh xe về phía trước xa nhất có thể mà không để lưng bị võng.',
          'Dùng cơ bụng kéo con lăn trở lại vị trí ban đầu.',
        ],
      },
      {
        'title': 'Bicycle Crunch',
        'muscles': ['Bụng trên', 'Cơ liên sườn'],
        'media': 'assets/videos/bung_6.gif',
        'steps': [
          'Nằm ngửa, nhấc chân theo tư thế đạp xe.',
          'Đưa khuỷu tay trái chạm đầu gối phải và ngược lại theo nhịp điệu.',
          'Đạp chân còn lại duỗi thẳng ra để tác động tối đa vào cơ bụng.',
        ],
      },
      {
        'title': 'V-Ups',
        'muscles': ['Bụng trên', 'Bụng dưới'],
        'media': 'assets/videos/bung_7.gif',
        'steps': [
          'Nằm ngửa, tay duỗi thẳng quá đầu, chân duỗi thẳng.',
          'Dùng cơ bụng gập người, đưa tay và chân lên chạm nhau tại một điểm ở giữa.',
          'Hạ người xuống từ từ về tư thế nằm phẳng ban đầu.',
        ],
      },
      {
        'title': 'Flutter Kicks',
        'muscles': ['Bụng dưới'],
        'media': 'assets/videos/bung_8.gif',
        'steps': [
          'Nằm ngửa, hai tay đặt dưới mông, nhấc hai chân lên khỏi sàn khoảng 15cm.',
          'Thực hiện đá chân lên xuống luân phiên (như đang bơi).',
          'Giữ chân thẳng và gồng chặt bụng dưới trong suốt quá trình.',
        ],
      },
    ],
    'CHÂN': [
      {
        'title': 'Barbell Squat',
        'muscles': ['Đùi trước', 'Mông', 'Lưng dưới'],
        'media': 'assets/videos/chan_1.gif',
        'steps': [
          'Đặt thanh đòn lên cơ cầu vai, đứng chân rộng bằng vai, mũi chân hơi hướng ra ngoài.',
          'Hạ người xuống như đang ngồi vào một chiếc ghế, giữ lưng thẳng và ngực ưỡn.',
          'Đẩy mạnh chân để đứng dậy và thở ra khi lên đến đỉnh.',
        ],
      },
      {
        'title': 'Leg Press',
        'muscles': ['Đùi trước', 'Mông'],
        'media': 'assets/videos/chan_2.gif',
        'steps': [
          'Ngồi vào máy, đặt hai chân lên bàn đạp rộng bằng vai.',
          'Mở khóa an toàn, hạ bàn đạp xuống chậm rãi cho đến khi đầu gối gần chạm ngực.',
          'Đẩy bàn đạp lên nhưng lưu ý không được khóa thẳng khớp gối ở vị trí cao nhất.',
        ],
      },
      {
        'title': 'Hack Squat',
        'muscles': ['Đùi trước'],
        'media': 'assets/videos/chan_3.gif',
        'steps': [
          'Đặt vai vào miếng đệm của máy, lưng áp sát vào tựa lưng.',
          'Hạ người xuống thấp nhất có thể trong khi vẫn giữ gót chân bám chặt trên bàn đạp.',
          'Sử dụng lực đùi trước để đẩy người trở lại vị trí ban đầu.',
        ],
      },
      {
        'title': 'Romanian Deadlift',
        'muscles': ['Đùi sau', 'Mông', 'Lưng dưới'],
        'media': 'assets/videos/chan_4.gif',
        'steps': [
          'Cầm thanh đòn hoặc tạ đơn trước đùi, chân rộng bằng vai.',
          'Đẩy mông ra sau, hạ tạ dọc theo ống chân trong khi giữ chân gần như thẳng (hơi chùng gối).',
          'Cảm nhận độ căng ở đùi sau rồi dùng cơ mông kéo người đứng thẳng dậy.',
        ],
      },
      {
        'title': 'Leg Extension',
        'muscles': ['Đùi trước'],
        'media': 'assets/videos/chan_5.gif',
        'steps': [
          'Ngồi vào máy, đặt mu bàn chân dưới thanh đệm.',
          'Dùng cơ đùi trước đá chân lên cho đến khi chân duỗi thẳng hoàn toàn.',
          'Hạ chân xuống thật chậm để duy trì áp lực lên cơ đùi.',
        ],
      },
      {
        'title': 'Leg Curl',
        'muscles': ['Đùi sau'],
        'media': 'assets/videos/chan_6.gif',
        'steps': [
          'Nằm sấp trên máy, đặt gót chân dưới thanh đệm.',
          'Cuộn chân lên phía mông, giữ xương chậu áp sát mặt đệm.',
          'Duỗi chân ra chậm rãi để kéo căng cơ đùi sau.',
        ],
      },
      {
        'title': 'Bulgarian Split Squat',
        'muscles': ['Đùi trước', 'Mông'],
        'media': 'assets/videos/chan_7.gif',
        'steps': [
          'Đứng quay lưng lại ghế, đặt mu bàn chân sau lên ghế.',
          'Hạ người xuống theo chiều thẳng đứng cho đến khi đùi chân trước song song với sàn.',
          'Giữ thăng bằng và đẩy người lên bằng gót chân trước.',
        ],
      },
      {
        'title': 'Standing Calf Raise',
        'muscles': ['Bắp chân'],
        'media': 'assets/videos/chan_8.gif',
        'steps': [
          'Đứng trên rìa của bục hoặc máy tập bắp chân.',
          'Nhón gót chân lên cao hết mức có thể, gồng chặt bắp chân trong 1 giây.',
          'Hạ gót chân xuống thấp hơn mức ban đầu để cơ bắp chân được giãn ra tối đa.',
        ],
      },
    ],
    'MÔNG': [
      {
        'title': 'Barbell Hip Thrust',
        'muscles': ['Mông', 'Đùi sau'],
        'media': 'assets/videos/mong_1.gif',
        'steps': [
          'Tựa lưng trên vào ghế phẳng, đặt thanh đòn ngang hông.',
          'Đẩy hông lên cao cho đến khi đùi và thân người tạo thành đường thẳng.',
          'Gồng chặt mông ở vị trí cao nhất trong 1-2 giây rồi hạ xuống.',
        ],
      },
      {
        'title': 'Glute Bridge',
        'muscles': ['Mông', 'Core'],
        'media': 'assets/videos/mong_2.gif',
        'steps': [
          'Nằm ngửa trên sàn, gập đầu gối, chân đặt sát mông.',
          'Nhấn gót chân xuống sàn để đẩy hông lên cao.',
          'Hạ hông xuống chậm rãi, tránh để mông chạm hẳn xuống sàn giữa các lần lặp.',
        ],
      },
      {
        'title': 'Cable Donkey Kick',
        'muscles': ['Mông'],
        'media': 'assets/videos/mong_3.gif',
        'steps': [
          'Đeo đai cáp vào cổ chân, đứng đối diện máy cáp.',
          'Đá chân ra sau và lên cao, giữ chân hơi cong hoặc thẳng tùy cảm nhận.',
          'Kiểm soát lực kéo của cáp khi đưa chân về vị trí cũ.',
        ],
      },
      {
        'title': 'Donkey Kick',
        'muscles': ['Mông'],
        'media': 'assets/videos/mong_4.gif',
        'steps': [
          'Quỳ trên sàn bằng hai tay và hai đầu gối (tư thế bò).',
          'Giữ đầu gối gập 90 độ, đá một chân lên phía trần nhà cho đến khi đùi song song với sàn.',
          'Gồng chặt cơ mông và từ từ hạ chân xuống.',
        ],
      },
      {
        'title': 'Fire Hydrant',
        'muscles': ['Mông nhỡ (cạnh mông)'],
        'media': 'assets/videos/mong_5.gif',
        'steps': [
          'Tư thế quỳ 4 điểm trên sàn như bài Donkey Kick.',
          'Giữ đầu gối gập, mở rộng chân sang bên hông giống như "vòi nước chữa cháy".',
          'Động tác này cực tốt để làm đầy phần lõm hai bên mông.',
        ],
      },
      {
        'title': 'Cable Hip Abduction',
        'muscles': ['Mông nhỡ', 'Đùi ngoài'],
        'media': 'assets/videos/mong_6.gif',
        'steps': [
          'Đứng nghiêng so với máy cáp, đeo đai vào cổ chân xa máy nhất.',
          'Đá chân sang ngang ra xa cơ thể, giữ người thẳng không nghiêng vẹo.',
          'Cảm nhận phần cơ mông bên hông hoạt động.',
        ],
      },
      {
        'title': 'Lever Seated Hip Abduction',
        'muscles': ['Mông nhỡ', 'Đùi ngoài'],
        'media': 'assets/videos/mong_7.mp4', // Video cho máy tập chuyên dụng
        'steps': [
          'Ngồi vào máy, đặt hai đầu gối vào phần đệm của máy.',
          'Dùng cơ mông đẩy hai chân mở rộng sang hai bên hết mức có thể.',
          'Khép chân lại chậm rãi để duy trì lực căng lên cơ hông.',
        ],
      },
    ],
    'THÂN TRÊN': [
      {
        'title': 'Incline Bench Press',
        'muscles': ['Ngực trên', 'Vai'],
        'media': 'assets/videos/nguc_3.mp4',
        'steps': [
          'Chỉnh ghế dốc lên khoảng 30-45 độ.',
          'Hạ thanh đòn xuống phần ngực trên (gần xương quai xanh).',
          'Đẩy tạ lên tập trung cảm nhận phần cơ ngực phía trên.',
        ],
      },
      {
        'title': 'Lat Pulldown',
        'muscles': ['Xô', 'Lưng trên'],
        'media': 'assets/videos/lung_3.gif',
        'steps': [
          'Ngồi vào máy kéo xô, hai tay nắm thanh cầm rộng hơn vai.',
          'Ưỡn ngực, kéo thanh cầm xuống sát phần ngực trên.',
          'Từ từ thả thanh cầm lên cao để cơ xô được giãn ra tối đa.',
        ],
      },
      {
        'title': 'Dumbbell Shoulder Press',
        'muscles': ['Vai', 'Tay sau'],
        'media': 'assets/videos/vai_2.gif',
        'steps': [
          'Ngồi trên ghế có tựa lưng, mỗi tay cầm một quả tạ đơn đặt ngang tai.',
          'Đẩy tạ lên cao cho đến khi hai cánh tay gần thẳng đứng.',
          'Hạ tạ xuống từ từ sao cho khuỷu tay vuông góc.',
        ],
      },
      {
        'title': 'Seated Cable Row',
        'muscles': ['Lưng giữa', 'Xô'],
        'media': 'assets/videos/lung_6.gif',
        'steps': [
          'Ngồi vào máy kéo cáp, hai chân đặt lên giá đỡ, hơi chùng gối.',
          'Kéo tay cầm về phía bụng, giữ lưng thẳng và ưỡn ngực.',
          'Thả tay về phía trước nhưng không được để lưng bị kéo theo.',
        ],
      },
      {
        'title': 'Lateral Raise',
        'muscles': ['Vai giữa'],
        'media': 'assets/videos/vai_4.gif',
        'steps': [
          'Đứng thẳng, hai tay cầm tạ đơn đặt bên hông.',
          'Dùng cơ vai nhấc tạ sang hai bên cho đến khi cánh tay song song với sàn.',
          'Hạ tạ xuống chậm để cảm nhận độ căng của cơ vai giữa.',
        ],
      },
      {
        'title': 'Barbell Curl',
        'muscles': ['Tay trước'],
        'media': 'assets/videos/tay_1.gif',
        'steps': [
          'Đứng thẳng, hai tay cầm thanh đòn lòng bàn tay hướng ra ngoài.',
          'Cuộn thanh đòn lên phía vai, giữ khuỷu tay sát mạn sườn.',
          'Hạ thanh đòn xuống chậm rãi để cơ tay trước được kéo căng.',
        ],
      },
      {
        'title': 'Triceps Pushdown',
        'muscles': ['Tay sau'],
        'media': 'assets/videos/tay_6.gif',
        'steps': [
          'Đứng trước máy cáp, hai tay cầm thanh ngang hoặc dây thừng.',
          'Gồng cơ tay sau đẩy cáp xuống cho đến khi tay duỗi thẳng hoàn toàn.',
          'Giữ khuỷu tay cố định sát người trong suốt quá trình tập.',
        ],
      },
    ],
    'THÂN DƯỚI': [
      {
        'title': 'Barbell Squat',
        'muscles': ['Đùi trước', 'Mông', 'Lưng dưới'],
        'media': 'assets/videos/chan_1.gif',
        'steps': [
          'Đặt thanh đòn lên cơ cầu vai, đứng chân rộng bằng vai.',
          'Hạ người xuống như đang ngồi vào ghế, giữ lưng thẳng.',
          'Đẩy mạnh chân để đứng dậy và thở ra.',
        ],
      },
      {
        'title': 'Romanian Deadlift',
        'muscles': ['Đùi sau', 'Mông'],
        'media': 'assets/videos/chan_4.gif',
        'steps': [
          'Đẩy mông ra sau, hạ tạ dọc theo ống chân.',
          'Giữ chân gần như thẳng để cảm nhận độ căng đùi sau.',
          'Dùng cơ mông kéo người đứng thẳng dậy.',
        ],
      },
      {
        'title': 'Leg Press',
        'muscles': ['Đùi trước', 'Mông'],
        'media': 'assets/videos/chan_2.gif',
        'steps': [
          'Đặt hai chân lên bàn đạp máy Leg Press rộng bằng vai.',
          'Hạ bàn đạp xuống chậm rãi cho đến khi gối gần chạm ngực.',
          'Đẩy mạnh lên nhưng không được khóa thẳng khớp gối.',
        ],
      },
      {
        'title': 'Leg Extension',
        'muscles': ['Đùi trước'],
        'media': 'assets/videos/chan_5.gif',
        'steps': [
          'Ngồi vào máy, đặt mu bàn chân dưới thanh đệm.',
          'Đá chân lên cao cho đến khi chân duỗi thẳng.',
          'Hạ xuống thật chậm để cảm nhận cơ đùi trước.',
        ],
      },
      {
        'title': 'Barbell Hip Thrust',
        'muscles': ['Mông', 'Đùi sau'],
        'media': 'assets/videos/mong_1.gif',
        'steps': [
          'Tựa lưng vào ghế, đặt thanh đòn ngang hông.',
          'Đẩy hông lên cao cho đến khi người thẳng hàng.',
          'Gồng chặt mông ở vị trí cao nhất trong 2 giây.',
        ],
      },
      {
        'title': 'Leg Curl',
        'muscles': ['Đùi sau'],
        'media': 'assets/videos/chan_6.gif',
        'steps': [
          'Nằm sấp hoặc ngồi vào máy, đặt gót chân dưới đệm.',
          'Cuộn chân lên sát mông và gồng chặt đùi sau.',
          'Duỗi chân ra chậm rãi có kiểm soát.',
        ],
      },
      {
        'title': 'Bicycle Crunch',
        'muscles': ['Bụng', 'Cơ liên sườn'],
        'media': 'assets/videos/bung_6.gif',
        'steps': [
          'Nằm ngửa, nhấc chân thực hiện động tác đạp xe.',
          'Đưa khuỷu tay trái chạm đầu gối phải và ngược lại.',
          'Giữ nhịp thở đều đặn theo từng vòng đạp.',
        ],
      },
      {
        'title': 'Standing Calf Raise',
        'muscles': ['Bắp chân'],
        'media': 'assets/videos/chan_8.gif',
        'steps': [
          'Đứng nhón gót chân lên cao hết mức có thể.',
          'Gồng chặt bắp chân ở đỉnh trong 1 giây.',
          'Hạ gót xuống thấp hơn mặt sàn để giãn cơ.',
        ],
      },
    ],
    'TOÀN THÂN': [
      {
        'title': 'Incline Bench Press',
        'muscles': ['Ngực trên', 'Vai'],
        'media': 'assets/videos/nguc_3.mp4',
        'steps': [
          'Chỉnh ghế dốc lên khoảng 30-45 độ.',
          'Hạ thanh đòn xuống phần ngực trên chậm rãi.',
          'Đẩy mạnh thanh đòn lên và tập trung cảm nhận cơ ngực.',
        ],
      },
      {
        'title': 'Dumbbell Shoulder Press',
        'muscles': ['Vai', 'Tay sau'],
        'media': 'assets/videos/vai_2.gif',
        'steps': [
          'Ngồi trên ghế, hai tay cầm tạ đơn đặt ngang tai.',
          'Đẩy tạ lên cao thẳng đứng qua đầu.',
          'Hạ tạ xuống từ từ cho đến khi khuỷu tay vuông góc.',
        ],
      },
      {
        'title': 'Lat Pulldown',
        'muscles': ['Xô', 'Lưng trên'],
        'media': 'assets/videos/lung_3.gif',
        'steps': [
          'Ngồi vào máy, hai tay nắm thanh cầm rộng hơn vai.',
          'Kéo thanh cầm xuống sát phần ngực trên, ưỡn ngực.',
          'Thả thanh cầm lên chậm rãi để cơ xô được kéo giãn.',
        ],
      },
      {
        'title': 'Overhead Triceps Extension',
        'muscles': ['Tay sau'],
        'media': 'assets/videos/tay_8.gif',
        'steps': [
          'Cầm tạ đơn bằng hai tay đưa cao quá đầu.',
          'Gập khuỷu tay hạ tạ xuống phía sau gáy.',
          'Đẩy mạnh tạ lên vị trí ban đầu bằng cơ tay sau.',
        ],
      },
      {
        'title': 'Barbell Curl',
        'muscles': ['Tay trước'],
        'media': 'assets/videos/tay_1.gif',
        'steps': [
          'Đứng thẳng, hai tay cầm thanh đòn lòng bàn tay hướng ra ngoài.',
          'Cuộn thanh đòn lên phía vai, giữ khuỷu tay cố định.',
          'Hạ xuống chậm để cảm nhận độ căng của cơ tay trước.',
        ],
      },
      {
        'title': 'Bicycle Crunch',
        'muscles': ['Bụng', 'Cơ liên sườn'],
        'media': 'assets/videos/bung_6.gif',
        'steps': [
          'Nằm ngửa, nhấc chân thực hiện động tác đạp xe.',
          'Đưa khuỷu tay trái chạm đầu gối phải và ngược lại.',
          'Gồng chặt bụng trong suốt quá trình thực hiện.',
        ],
      },
      {
        'title': 'Romanian Deadlift',
        'muscles': ['Đùi sau', 'Mông', 'Lưng dưới'],
        'media': 'assets/videos/chan_4.gif',
        'steps': [
          'Đẩy mông ra sau, hạ tạ dọc theo ống chân.',
          'Giữ lưng thẳng, cảm nhận đùi sau căng ra.',
          'Dùng cơ mông và đùi sau kéo người đứng thẳng dậy.',
        ],
      },
      {
        'title': 'Barbell Squat',
        'muscles': ['Đùi trước', 'Mông'],
        'media': 'assets/videos/chan_1.gif',
        'steps': [
          'Đặt thanh đòn lên vai, đứng chân rộng bằng vai.',
          'Hạ người xuống sâu như tư thế ngồi ghế.',
          'Đẩy mạnh gót chân để đứng thẳng dậy.',
        ],
      },
      {
        'title': 'Standing Calf Raise',
        'muscles': ['Bắp chân'],
        'media': 'assets/videos/chan_8.gif',
        'steps': [
          'Đứng nhón gót chân lên cao nhất có thể.',
          'Giữ 1 giây ở đỉnh để bắp chân gồng cứng.',
          'Hạ gót xuống thấp hơn mặt sàn để giãn cơ tối đa.',
        ],
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    final workouts = _workoutData[categoryName] ?? [];

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [

          ///  APPBAR LUXURY
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                categoryName,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(categoryImageUrl, fit: BoxFit.cover),

                  ///  overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.85),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          ///  LIST
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final workout = workouts[index];

                  ///  animation fade + slide
                  return TweenAnimationBuilder(
                    duration: Duration(milliseconds: 400 + (index * 80)),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 30 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: _buildLuxuryCard(context, workout),
                  );
                },
                childCount: workouts.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///  CARD 
  Widget _buildLuxuryCard(
    BuildContext context,
    Map<String, dynamic> workout,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ExerciseDetailScreen(
              exerciseName: workout['title'],
              mediaPath: workout['media'],
              steps: List<String>.from(workout['steps']),
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ///  MEDIA PREVIEW
            ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Stack(
                children: [

                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.asset(
                      categoryImageUrl, // dùng tạm ảnh category
                      fit: BoxFit.cover,
                    ),
                  ),

                  ///  overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.center,
                          colors: [
                            Colors.black.withValues(alpha: 0.7),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// play button
                  Positioned.fill(
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            ///  TITLE
            Text(
              workout['title'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            ///  MUSCLE TAGS
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: (workout['muscles'] as List<String>)
                  .map((m) => _luxChip(m))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  ///  CHIP 
  Widget _luxChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
