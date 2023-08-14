import 'package:eqms_test/Api/DraggableSheetModel.dart';
import 'package:eqms_test/Api/GoogleMapModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../style/color_guide.dart';
class CustomCategory extends StatefulWidget {
  const CustomCategory({super.key});

  @override
  State<CustomCategory> createState() => _CustomCategoryState();
}

class _CustomCategoryState extends State<CustomCategory> {
  int? _selectedIndex;
  bool isSelected = false;

  List<Widget> choiceChips() {
    List<Widget> chips = [];
    for (int i = 0; i < _choiceChipsList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 2.5, right: 2.5),
        child: ChoiceChip(
          label: Row(
            children: [
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                    _selectedIndex == i ? Colors.white : primaryDark,
                    BlendMode.srcIn
                ),
                child: SvgPicture.asset(_choiceChipsList[i].iconPath, width: 20, height: 20),
              ),
              const SizedBox(width: 7,),
              Text(_choiceChipsList[i].label),
            ],
          ),
          backgroundColor: Colors.white,
          selected: _selectedIndex == i,
          selectedColor: Colors.deepOrange,
          labelStyle: TextStyle(
            color: _selectedIndex == i ? Colors.white : Colors.black,
          ),
          onSelected: (bool selected) {
            setState(() {
              _selectedIndex = selected ? i : null;
              _handleSelection(_selectedIndex);
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

  void _handleSelection(int? selectedIndex) {
    final mapModel = context.read<GoogleMapModel>();
    final draggModel = context.read<DraggableSheetModel>();

    switch (_selectedIndex) {
      case null:
      case 3:
        mapModel.RemoveItems();
        draggModel.resetDraggableSheetHeight();
        break;
      case 0:
        mapModel.EarthQuakeItems();
        draggModel.adjustDraggableSheetHeight();
        break;
      case 1:
        mapModel.ShelterItems();
        draggModel.adjustDraggableSheetHeight();
        break;
      case 2:
        mapModel.EmergencyInstItems();
        draggModel.adjustDraggableSheetHeight();
      default:
        mapModel.RemoveItems();
        draggModel.adjustDraggableSheetHeight();
        break;
    }
  }

}

class ChipData {
  String label;
  String iconPath;

  ChipData(this.label, this.iconPath);
}

final List<ChipData> _choiceChipsList = [
  ChipData("지진 정보", "assets/earthquake.svg"),
  ChipData("내 주변 대피소", "assets/shelter.svg"),
  ChipData("응급시설", "assets/emergeInst.svg"),
  ChipData("권역외상센터", "assets/traumaCenter.svg")
];
