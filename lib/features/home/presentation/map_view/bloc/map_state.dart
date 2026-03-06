import 'package:equatable/equatable.dart';

class PoiData extends Equatable {
  final double top;
  final double left;
  final String label;

  const PoiData({required this.top, required this.left, required this.label});

  @override
  List<Object?> get props => [top, left, label];
}

class FloorData extends Equatable {
  final String name;
  final String image;
  final List<PoiData> pois;

  const FloorData({
    required this.name,
    required this.image,
    this.pois = const [],
  });

  @override
  List<Object?> get props => [name, image, pois];
}

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object?> get props => [];
}

class MapInitial extends MapState {
  final List<FloorData> floors;
  final int selectedFloorIndex;
  final double currentScale;

  const MapInitial({
    required this.floors,
    this.selectedFloorIndex = 0,
    this.currentScale = 1.0,
  });

  FloorData get currentFloor => floors[selectedFloorIndex];

  @override
  List<Object?> get props => [floors, selectedFloorIndex, currentScale];

  MapInitial copyWith({
    List<FloorData>? floors,
    int? selectedFloorIndex,
    double? currentScale,
  }) {
    return MapInitial(
      floors: floors ?? this.floors,
      selectedFloorIndex: selectedFloorIndex ?? this.selectedFloorIndex,
      currentScale: currentScale ?? this.currentScale,
    );
  }

  // Static floor data
  static List<FloorData> getDefaultFloors() {
    return [
      FloorData(
        name: "bunker",
        image: "assets/hinhanh1.png",
        pois: [
          const PoiData(top: 150, left: 200, label: "19"),
          const PoiData(top: 180, left: 160, label: "35"),
          const PoiData(top: 200, left: 180, label: "13"),
          const PoiData(top: 190, left: 210, label: "39"),
        ],
      ),
      FloorData(
        name: "ground",
        image: "assets/hinhanh2.png",
        pois: [
          const PoiData(top: 150, left: 100, label: "01"),
          const PoiData(top: 150, left: 130, label: "02"),
          const PoiData(top: 150, left: 160, label: "03"),
          const PoiData(top: 150, left: 190, label: "04"),
          const PoiData(top: 120, left: 160, label: "05"),
          const PoiData(top: 180, left: 160, label: "06"),
        ],
      ),
      FloorData(
        name: "L1",
        image: "assets/hinhanh3.png",
        pois: [
          const PoiData(top: 150, left: 150, label: "07"),
          const PoiData(top: 120, left: 120, label: "08"),
          const PoiData(top: 90, left: 90, label: "09"),
          const PoiData(top: 120, left: 180, label: "10"),
          const PoiData(top: 90, left: 210, label: "11"),
          const PoiData(top: 180, left: 120, label: "12"),
          const PoiData(top: 210, left: 90, label: "13"),
          const PoiData(top: 180, left: 180, label: "14"),
          const PoiData(top: 210, left: 210, label: "15"),
        ],
      ),
      FloorData(
        name: "L2",
        image: "assets/hinhanh1.png",
        pois: [const PoiData(top: 100, left: 100, label: "01")],
      ),
      FloorData(
        name: "L3",
        image: "assets/hinhanh2.png",
        pois: [
          const PoiData(top: 150, left: 100, label: "77"),
          const PoiData(top: 150, left: 130, label: "88"),
          const PoiData(top: 150, left: 160, label: "99"),
          const PoiData(top: 150, left: 190, label: "16"),
          const PoiData(top: 120, left: 160, label: "97"),
          const PoiData(top: 180, left: 160, label: "96"),
        ],
      ),
      FloorData(
        name: "L4",
        image: "assets/hinhanh3.png",
        pois: [
          const PoiData(top: 150, left: 200, label: "59"),
          const PoiData(top: 180, left: 160, label: "45"),
          const PoiData(top: 200, left: 180, label: "33"),
          const PoiData(top: 190, left: 210, label: "29"),
        ],
      ),
      FloorData(
        name: "EX1",
        image: "assets/hinhanh1.png",
        pois: [
          const PoiData(top: 150, left: 150, label: "17"),
          const PoiData(top: 120, left: 120, label: "28"),
          const PoiData(top: 90, left: 90, label: "39"),
          const PoiData(top: 120, left: 180, label: "40"),
          const PoiData(top: 90, left: 210, label: "51"),
          const PoiData(top: 180, left: 120, label: "62"),
          const PoiData(top: 210, left: 90, label: "73"),
          const PoiData(top: 180, left: 180, label: "84"),
          const PoiData(top: 210, left: 210, label: "95"),
        ],
      ),
      FloorData(name: "EX2", image: "assets/hinhanh2.png", pois: const []),
    ];
  }
}
