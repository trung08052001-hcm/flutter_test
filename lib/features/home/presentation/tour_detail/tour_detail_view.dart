import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_testt/features/home/presentation/tour_detail/bloc/tour_detail_bloc.dart';
import 'package:flutter_testt/features/home/presentation/tour_detail/bloc/tour_detail_event.dart';
import 'package:flutter_testt/features/home/presentation/tour_detail/bloc/tour_detail_state.dart';
import 'package:flutter_testt/widget/background_theme.dart';

class TourDetailView extends StatelessWidget {
  final String title;
  final String audioFile;
  final VoidCallback? onClose;

  const TourDetailView({
    super.key,
    required this.title,
    required this.audioFile,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Lớp nền viền ngoài (Ảnh thành phố/nền của bạn)
          const BackgroundContainer(),

          // 2. Lớp nội dung Playlist nằm ở giữa
          Center(
            child: Container(
              // Chiều rộng này nên khớp với phần hở của BackgroundContainer (thường từ 320-380)
              constraints: const BoxConstraints(maxWidth: 360),
              // Căn chỉnh lề trên/dưới để nội dung không đè lên viền của khung Background
              margin: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: BlocProvider(
                  create: (context) =>
                      TourDetailBloc()
                        ..add(TourDetailInitializeEvent(audioFile)),
                  child: _TourDetailViewContent(title: title, onClose: onClose),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TourDetailViewContent extends StatelessWidget {
  final String title;
  final VoidCallback? onClose;

  const _TourDetailViewContent({required this.title, this.onClose});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        Expanded(
          child: SingleChildScrollView(
            // Padding này giúp tấm hình và chữ không bị dính sát mép "màn hình nhỏ"
            padding: const EdgeInsets.all(20),
            child: Column(
              // Căn giữa tấm hình và các thành phần bên trong
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/imagepage1.png',
                    fit: BoxFit.cover,
                    width: double
                        .infinity, // Hình sẽ chiếm hết chiều rộng đã trừ padding
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  "พระราชวังเอกราชไม่ใช่เพียงอาคารธรรมดา...",
                  textAlign:
                      TextAlign.center, // Căn giữa chữ cho đồng bộ với hình
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        _buildPlayerControl(context),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: const Color(0xFFB71C1C),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          IconButton(
            onPressed: onClose ?? () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center, // Căn giữa tiêu đề
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Thêm một SizedBox để cân bằng với nút Back, giúp tiêu đề nằm đúng giữa
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildPlayerControl(BuildContext context) {
    return BlocBuilder<TourDetailBloc, TourDetailState>(
      builder: (context, state) {
        bool isPlaying = false;
        Duration duration = Duration.zero;
        Duration position = Duration.zero;

        if (state is TourDetailReady) {
          isPlaying = state.isPlaying;
          duration = state.duration;
          position = state.position;
        }

        return Container(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            bottom: 20,
            top: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey.shade200)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 3,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 6,
                  ),
                  activeTrackColor: Colors.black,
                  inactiveTrackColor: Colors.grey.shade300,
                  thumbColor: Colors.black,
                ),
                child: Slider(
                  min: 0,
                  max: duration.inSeconds.toDouble().clamp(1, double.infinity),
                  value: position.inSeconds.toDouble().clamp(
                    0,
                    duration.inSeconds.toDouble(),
                  ),
                  onChanged: (value) {
                    context.read<TourDetailBloc>().add(
                      TourDetailSeekEvent(Duration(seconds: value.toInt())),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          isPlaying
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_filled,
                          size: 35,
                        ),
                        onPressed: () => context.read<TourDetailBloc>().add(
                          TourDetailPlayPauseEvent(),
                        ),
                      ),
                      Text(
                        "${_formatTime(position)} / ${_formatTime(duration)}",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Icon(Icons.volume_up, size: 22, color: Colors.black54),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatTime(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }
}
