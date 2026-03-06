import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_testt/features/home/presentation/map_view/bloc/map_bloc.dart';
import 'package:flutter_testt/features/home/presentation/map_view/bloc/map_event.dart';
import 'package:flutter_testt/features/home/presentation/map_view/bloc/map_state.dart';

class MapView extends StatefulWidget {
  final Function(String label)? onPoiTap;

  const MapView({super.key, this.onPoiTap});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late final TransformationController _transformationController;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    _transformationController.addListener(_onTransformChanged);
  }

  void _onTransformChanged() {
    final scale = _transformationController.value.getMaxScaleOnAxis();
    context.read<MapBloc>().add(MapScaleChangedEvent(scale));
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        if (state is! MapInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            Expanded(child: _buildMapContent(state)),
            _buildFloorSelector(state),
          ],
        );
      },
    );
  }

  Widget _buildMapContent(MapInitial state) {
    return InteractiveViewer(
      transformationController: _transformationController,
      minScale: 0.5,
      maxScale: 5.0,
      child: Center(
        child: Stack(
          children: [
            Image.asset(state.currentFloor.image, fit: BoxFit.contain),
            ...state.currentFloor.pois.map(
              (poi) => _buildPoiButton(
                poi,
                state.currentScale,
                state.currentFloor.name,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPoiButton(PoiData poi, double scale, String floorName) {
    final baseSize = 20.0;
    final scaledSize = baseSize / scale;

    return Positioned(
      top: poi.top,
      left: poi.left,
      child: GestureDetector(
        onTap: () {
          if (widget.onPoiTap != null) {
            widget.onPoiTap!(poi.label);
          } else {
            print("Nhấn vào POI ${poi.label} của tầng $floorName");
          }
        },
        child: Container(
          width: scaledSize,
          height: scaledSize,
          decoration: const BoxDecoration(
            color: Color(0xFFB71C1C),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              poi.label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12 / scale,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFloorSelector(MapInitial state) {
    return Container(
      height: 70,
      color: Colors.black,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: state.floors.length,
        itemBuilder: (context, index) {
          final isSelected = state.selectedFloorIndex == index;
          return GestureDetector(
            onTap: () {
              _transformationController.value = Matrix4.identity();
              context.read<MapBloc>().add(MapFloorChangedEvent(index));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected ? Colors.red : Colors.transparent,
                    width: 3,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.layers,
                    color: isSelected ? Colors.red : Colors.white,
                    size: 22,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    state.floors[index].name.toUpperCase(),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontSize: 10,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
