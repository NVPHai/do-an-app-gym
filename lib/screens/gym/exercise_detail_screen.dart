import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ExerciseDetailScreen extends StatefulWidget {
  final String exerciseName;
  final String mediaPath;
  final List<String> steps;

  const ExerciseDetailScreen({
    super.key,
    required this.exerciseName,
    required this.mediaPath,
    required this.steps,
  });

  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  VideoPlayerController? _controller;
  bool isVideo = false;

  @override
  void initState() {
    super.initState();
    isVideo = widget.mediaPath.toLowerCase().endsWith('.mp4');

    if (isVideo) {
      _controller = VideoPlayerController.asset(widget.mediaPath)
        ..initialize().then((_) {
          setState(() {});
          _controller?.play();
          _controller?.setLooping(true);
          _controller?.setVolume(0);
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Stack(
        children: [

          ///  BACKGROUND
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0D1B2A),
                  Color(0xFF1B263B),
                  Color(0xFF000000),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          /// CONTENT
          CustomScrollView(
            slivers: [

              ///  VIDEO HEADER
              SliverAppBar(
                expandedHeight: 280,
                pinned: true,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    widget.exerciseName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [

                      /// VIDEO / IMAGE
                      isVideo
                          ? (_controller != null &&
                                  _controller!.value.isInitialized)
                              ? FittedBox(
                                  fit: BoxFit.cover,
                                  child: SizedBox(
                                    width: _controller!.value.size.width,
                                    height: _controller!.value.size.height,
                                    child: VideoPlayer(_controller!),
                                  ),
                                )
                              : const Center(
                                  child: CircularProgressIndicator(),
                                )
                          : Image.asset(
                              widget.mediaPath,
                              fit: BoxFit.cover,
                            ),

                      /// OVERLAY DARK
                      Container(
                        color: Colors.black.withValues(alpha: 0.4),
                      ),
                    ],
                  ),
                ),
              ),

              ///  CONTENT
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([

                    ///  TITLE
                    const Text(
                      "HƯỚNG DẪN",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    ///  STEPS
                    ...List.generate(
                      widget.steps.length,
                      (index) => _buildStep(index + 1, widget.steps[index]),
                    ),

                    const SizedBox(height: 100),
                  ]),
                ),
              ),
            ],
          ),

          ///  BUTTON FLOATING
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: _buildBottomButton(),
          ),
        ],
      ),
    );
  }

  ///  STEP CARD 
  Widget _buildStep(int number, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// NUMBER
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFD4AF37),
            ),
            child: Center(
              child: Text(
                "$number",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(width: 15),

          /// TEXT
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                height: 1.5,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///  BUTTON
  Widget _buildBottomButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD4AF37),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "ĐÓNG",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}