import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CardioDetailScreen extends StatefulWidget {
  final Map<String, dynamic> workout;
  const CardioDetailScreen({super.key, required this.workout});

  @override
  State<CardioDetailScreen> createState() => _CardioDetailScreenState();
}

class _CardioDetailScreenState extends State<CardioDetailScreen> {
  VideoPlayerController? _controller;
  bool isVideo = false;

  Timer? _timer;
  int _secondsRemaining = 0;
  int _countdown = 0;
  bool _isStarted = false;
  bool _isFinished = false; 

  @override
  void initState() {
    super.initState();
    _secondsRemaining = widget.workout['duration'] ?? 30;
    isVideo = (widget.workout['media'] as String).endsWith('.mp4');

    if (isVideo) {
      _controller = VideoPlayerController.asset(widget.workout['media'])
        ..initialize().then((_) {
          setState(() {});
          _controller?.setLooping(true);
          _controller?.setVolume(0);
        });
    }
  }

    void _startWorkout() {
      setState(() => _countdown = 3);

      Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (_countdown > 1) {
            _countdown--;
          } else {
            _countdown = 0;
            _isStarted = true;
            timer.cancel();
            _startMainTimer();
            _controller?.play();
          }
        });
      });
    }

  void _startMainTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _isFinished = true;
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
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
          Positioned.fill(
            child: isVideo
                ? (_controller?.value.isInitialized ?? false
                    ? FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _controller!.value.size.width,
                          height: _controller!.value.size.height,
                          child: VideoPlayer(_controller!),
                        ),
                      )
                    : Container(color: Colors.black))
                : Image.asset(
                    widget.workout['media'],
                    fit: BoxFit.cover,
                  ),
          ),

          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.7),
            ),
          ),

          ///  CONTENT
          SafeArea(
            child: Column(
              children: [

                /// HEADER
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Spacer(),
                      Text(
                        widget.workout['title'] ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),

                /// VIDEO BOX 
                _buildMedia(),

                /// TIMER
                Text(
                  "00:${_secondsRemaining.toString().padLeft(2, '0')}",
                  style: const TextStyle(
                    fontSize: 60,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  _isFinished
                      ? "DONE 🔥"
                      : (_isStarted ? "KEEP GOING" : "READY"),
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),

                /// STEPS
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: (widget.workout['steps'] as List)
                        .asMap()
                        .entries
                        .map((e) => _buildStep(e.key + 1, e.value))
                        .toList(),
                  ),
                ),

                const SizedBox(height: 80),
              ],
            ),
          ),

          ///  BUTTON
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: _buildButton(),
          ),

          /// COUNTDOWN
          if (_countdown > 0)
            Container(
              color: Colors.black.withValues(alpha: 0.7),
              child: Center(
                child: Text(
                  "$_countdown",
                  style: const TextStyle(
                    fontSize: 120,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// VIDEO 
  Widget _buildMedia() {
    return Container(
      height: 230,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black,
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
        child: isVideo
            ? (_controller != null && _controller!.value.isInitialized
                ? Center(
                    child: AspectRatio(
                      aspectRatio: _controller!.value.aspectRatio,
                      child: VideoPlayer(_controller!),
                    ),
                  )
                : const Center(child: CircularProgressIndicator()))
            : Image.asset(
                widget.workout['media'],
                fit: BoxFit.contain, 
              ),
      ),
    );
  }

  /// STEP
  Widget _buildStep(int num, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFD4AF37),
            ),
            child: Center(
              child: Text(
                "$num",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  ///  BUTTON
  Widget _buildButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: _isFinished
                ? Colors.orange
                : const Color(0xFFD4AF37),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          onPressed: () {
            if (!_isStarted && !_isFinished) {
              _startWorkout();
            } else {
              Navigator.pop(context);
            }
          },
          child: Text(
            _isFinished ? "DONE" : (_isStarted ? "STOP" : "START"),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}