import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_testt/features/home/bloc/home_bloc.dart';
import 'package:flutter_testt/features/home/bloc/home_event.dart';
import 'package:flutter_testt/features/home/bloc/home_state.dart';
import 'package:flutter_testt/features/home/presentation/keypad/bloc/keypad_bloc.dart';
import 'package:flutter_testt/features/home/presentation/keypad/bloc/keypad_event.dart';
import 'package:flutter_testt/features/home/presentation/keypad/bloc/keypad_state.dart';

class KeypadView extends StatelessWidget {
  const KeypadView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => KeypadBloc()..add(KeypadInitialEvent()),
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeInitial && state.resetKeypad) {
            // Reset keypad when tour detail is closed
            context.read<KeypadBloc>().add(KeypadClearEvent());
            // Reset the flag
            context.read<HomeBloc>().add(HomeResetKeypadEvent());
          }
        },
        child: BlocListener<KeypadBloc, KeypadState>(
          listener: (context, state) {
            if (state is KeypadSubmitted) {
              final inputCode = state.inputCode;
              // Dispatch event to HomeBloc to show TourDetailView
              context.read<HomeBloc>().add(HomeCodeSubmittedEvent(inputCode));
            }
          },
          child: const _KeypadViewContent(),
        ),
      ),
    );
  }
}

class _KeypadViewContent extends StatelessWidget {
  const _KeypadViewContent();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFD9E5F6),
      child: Column(
        children: [
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Enter the keycode of the content you want to see",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ),
          const Spacer(),
          // Số hiển thị mã POI
          BlocBuilder<KeypadBloc, KeypadState>(
            builder: (context, state) {
              String displayCode = "0 0";
              if (state is KeypadInitial) {
                displayCode = state.inputCode.isEmpty
                    ? "0 0"
                    : state.inputCode.split('').join(' ');
              }
              return Text(
                displayCode,
                style: const TextStyle(
                  fontSize: 54,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 4,
                ),
              );
            },
          ),
          const Spacer(),
          // Bàn phím số
          _buildKeypad(context),
          const SizedBox(height: 20),
          // Nút Ok xác nhận
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: ElevatedButton(
              onPressed: () {
                context.read<KeypadBloc>().add(KeypadSubmitEvent());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE0E0F8),
                foregroundColor: Colors.black87,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                "Ok",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _buildKeypad(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        childAspectRatio: 2.1,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildKey(context, "1"),
          _buildKey(context, "2"),
          _buildKey(context, "3"),
          _buildKey(context, "4"),
          _buildKey(context, "5"),
          _buildKey(context, "6"),
          _buildKey(context, "7"),
          _buildKey(context, "8"),
          _buildKey(context, "9"),
          const SizedBox.shrink(),
          _buildKey(context, "0"),
          _buildKey(context, "backspace", isIcon: true),
        ],
      ),
    );
  }

  Widget _buildKey(BuildContext context, String value, {bool isIcon = false}) {
    return ElevatedButton(
      onPressed: () {
        if (isIcon) {
          context.read<KeypadBloc>().add(KeypadBackspacePressedEvent());
        } else {
          context.read<KeypadBloc>().add(KeypadNumberPressedEvent(value));
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: EdgeInsets.zero,
      ),
      child: isIcon
          ? const Icon(Icons.backspace_outlined, size: 22)
          : Text(
              value,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
    );
  }
}
