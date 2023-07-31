import 'package:dio/dio.dart';
import 'package:eqms_test/Api/Retrofit/RestClient.dart';
import 'package:eqms_test/Widget/google_map/models/MapItems.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class CustomCategory extends StatefulWidget {
  const CustomCategory({super.key});

  @override
  State<CustomCategory> createState() => _CustomCategoryState();
}

class _CustomCategoryState extends State<CustomCategory> {
  int? _selectedIndex;

  List<Widget> choiceChips(){
    List<Widget> chips = [];
    for(int i=0; i<_choiceChipsList.length; i++){
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 2.5, right: 2.5),
        child: ChoiceChip(
          avatar: CircleAvatar(
            child: Icon(_choiceChipsList[i].iconData),
          ),
          label: Text(_choiceChipsList[i].label),
          backgroundColor: Colors.white,
          selected: _selectedIndex == i,
          selectedColor: Colors.deepOrange,
          onSelected: (bool selected){
            setState(() {
              _selectedIndex = selected ? i : null;
            });
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
        child: Row(
          children: choiceChips(),
        ),
      ),
    );
  }

}

class ChipData {
  String label;
  IconData iconData;

  ChipData(this.label, this.iconData);
}

final List<ChipData> _choiceChipsList = [
  ChipData("지진 정보", Icons.add),
  ChipData("내 주변 대피소", Icons.add),
  ChipData("응급시설", Icons.add),
  ChipData("권역외상센터", Icons.add)
];


mixin ItemData {
  final dio = Dio();
  late RestClient client;
  List<Circle> circleData = [];
  List<ClusterData> markerData = [];

  void getEarthQuakeData() {
    client = RestClient(dio);
    client.getEarthQuake().then((value) {
      if (value.isNotEmpty){
        circleData = [
          for(int i=0; i<value.length; i++)
            Circle(
              circleId: CircleId(value[i].id.toString()),
              center: LatLng(value[i].latitude, value[i].longitude),
              fillColor: Colors.blue.withOpacity(0.5),
              radius: value[i].magnitude * 10000,
              strokeColor: Colors.blueAccent,
              strokeWidth: 1,
              consumeTapEvents: true,
            ),
        ];
      }
    });
  }

  void getShelterData() {
    client = RestClient(dio);
    client.getShelter().then((value) {
      if (value.isNotEmpty){
        markerData = [
          for(int i=0; i<value.length; i++)
            ClusterData(
              id: value[i].id.toString(),
              address: value[i].dtl_adres,
              latLng: LatLng(value[i].ycord, value[i].xcord)
            ),
        ];
      }
    });
  }

}