import 'package:eqms_test/Api/GoogleMapModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomFloatingButton extends StatelessWidget {
  final VoidCallback onMoveCamera;
  const CustomFloatingButton({required this.onMoveCamera, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      FloatingActionButton(
        heroTag: 'tag1',
        mini: true,
        onPressed: () {
          onMoveCamera();
        },
        child: const Icon(Icons.location_pin),
      ),
      const SizedBox(
        height: 5,
      ),
      FloatingActionButton(
        heroTag: 'tag2',
        mini: true,
        child: const Icon(Icons.refresh),
        onPressed: () {
          switch (context.read<GoogleMapModel>().sheetTitle) {
            case "내 주변 대피소":
              context.read<GoogleMapModel>().ShelterItems();
              break;
            case "최근 발생 지진":
              context.read<GoogleMapModel>().EarthQuakeItems();
              break;
            case "센서":
              context.read<GoogleMapModel>().SensorItems();
              break;
            default:
              break;
          }
        },
      ),
      // 아마 이걸로 움직이는 거 생각할 수 있지 않을가??
    ]);
  }
}
