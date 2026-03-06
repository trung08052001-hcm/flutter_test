import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_testt/features/home/presentation/tour_detail/bloc/tour_detail_bloc.dart';
import 'package:flutter_testt/features/home/presentation/tour_detail/bloc/tour_detail_event.dart';
import 'package:flutter_testt/features/home/presentation/tour_detail/bloc/tour_detail_state.dart';

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
    return BlocProvider(
      create: (context) =>
          TourDetailBloc()..add(TourDetailInitializeEvent(audioFile)),
      child: _TourDetailViewContent(title: title, onClose: onClose),
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
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Image.asset('assets/imagepage1.png', fit: BoxFit.cover),
                const SizedBox(height: 20),
                const Text(
                  "พระราชวังเอกราชไม่ใช่เพียงอาคารธรรมดา...",
                  style: TextStyle(fontSize: 16, height: 1.5),
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
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Slider(
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
                activeColor: Colors.black,
                inactiveColor: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                        onPressed: () {
                          context.read<TourDetailBloc>().add(
                            TourDetailPlayPauseEvent(),
                          );
                        },
                      ),
                      Text(
                        "${_formatTime(position)} / ${_formatTime(duration)}",
                      ),
                    ],
                  ),
                  const Icon(Icons.volume_up),
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
