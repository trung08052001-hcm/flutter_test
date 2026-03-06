import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_testt/features/home/bloc/home_bloc.dart';
import 'package:flutter_testt/features/home/bloc/home_event.dart';
import 'package:flutter_testt/features/home/bloc/home_state.dart';
import 'package:flutter_testt/features/home/presentation/home_language/home_language_selector.dart';
import 'package:flutter_testt/features/home/presentation/keypad/keypad_view.dart';
import 'package:flutter_testt/features/home/presentation/map_view/bloc/map_bloc.dart';
import 'package:flutter_testt/features/home/presentation/map_view/map_view.dart';
import 'package:flutter_testt/features/home/presentation/tour_detail/tour_detail_view.dart';
import 'package:flutter_testt/widget/background_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(HomeInitialEvent()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _showLanguage = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        int selectedIndex = 0;
        bool showTourDetail = false;
        String? submittedCode;
        bool? isOdd;

        if (state is HomeInitial) {
          selectedIndex = state.selectedIndex;
          showTourDetail = state.showTourDetail;
          submittedCode = state.submittedCode;
          isOdd = state.isOdd;
        }

        return Scaffold(
          body: Stack(
            children: [
              BackgroundContainer(),
              Container(color: Colors.black.withOpacity(0.1)),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  constraints: const BoxConstraints(maxWidth: 400),
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 10),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            _buildRedHeader(),
                            Expanded(
                              child: selectedIndex == 0
                                  ? _buildListContent()
                                  : selectedIndex == 1
                                  ? const KeypadView()
                                  : BlocProvider(
                                      create: (_) => MapBloc(),
                                      child: MapView(
                                        onPoiTap: (label) {
                                          final labelNum =
                                              int.tryParse(label) ?? 0;
                                          final isOddValue = labelNum % 2 != 0;
                                          context.read<HomeBloc>().add(
                                            HomeShowTourDetailEvent(
                                              label: label,
                                              isOdd: isOddValue,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                            ),
                            _buildRedBottomNav(selectedIndex),
                          ],
                        ),
                        if (_showLanguage)
                          Positioned.fill(
                            child: Container(
                              color: Colors.black54,
                              child: Center(
                                child: HomeLanguageSelector(
                                  onClose: () =>
                                      setState(() => _showLanguage = false),
                                  onLanguageSelected: (String language) {
                                    print("Selected: $language");
                                    setState(() => _showLanguage = false);
                                  },
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              if (showTourDetail && submittedCode != null && isOdd != null)
                Material(
                  color: Colors.white,
                  child: TourDetailView(
                    title: "POI $submittedCode",
                    audioFile: isOdd
                        ? 'SoundHelix-Song-1.mp3'
                        : 'SoundHelix-Song-8.mp3',
                    onClose: () {
                      context.read<HomeBloc>().add(HomeCloseTourDetailEvent());
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // --- CÁC HÀM HELPER NẰM TRONG CLASS ---
  Widget _buildRedHeader() {
    return Container(
      color: const Color(0xFFB71C1C),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.arrow_back, color: Colors.white),
          const Text(
            "POI",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.language, color: Colors.white),
                onPressed: () => setState(() => _showLanguage = true),
              ),
              const Icon(Icons.grid_view, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRedBottomNav(int selectedIndex) {
    return Container(
      color: const Color(0xFFB71C1C),
      child: BottomNavigationBar(
        backgroundColor: const Color(0xFFB71C1C),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) =>
            context.read<HomeBloc>().add(HomeTabChangedEvent(index)),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'รายการ'),
          BottomNavigationBarItem(
            icon: Icon(Icons.keyboard),
            label: 'แป้นพิมพ์',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'แผนที่'),
        ],
      ),
    );
  }

  final List<String> _imagePages = [
    'assets/fullimage.png',
    'assets/imagepage1.png',
    'assets/imagepage2.png',
    'assets/imagepage3.png',
    'assets/imagepage4.png',
    'assets/fullimage.png',
    'assets/imagepage1.png',
    'assets/imagepage2.png',
    'assets/imagepage3.png',
  ];

  Widget _buildListContent() {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: 15,
      itemBuilder: (context, index) => _buildTourItem(index),
    );
  }

  Widget _buildTourItem(int index) {
    final String imagePath = _imagePages[index % 4];
    final int itemNumber = index + 1;
    final bool isOdd = itemNumber % 2 != 0;

    return GestureDetector(
      onTap: () => context.read<HomeBloc>().add(
        HomeShowTourDetailEvent(
          label: itemNumber.toString().padLeft(2, '0'),
          isOdd: isOdd,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              child: Image.asset(
                imagePath,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              color: const Color(0xFFB71C1C),
              child: Text(
                "$itemNumber - พระราชวังเอกราช",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
} //
