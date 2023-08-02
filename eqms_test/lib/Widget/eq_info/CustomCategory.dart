import 'package:eqms_test/Api/GoogleMapModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CustomCategory extends StatefulWidget {
  const CustomCategory({super.key});

  @override
  State<CustomCategory> createState() => _CustomCategoryState();
}

class _CustomCategoryState extends State<CustomCategory> {
  int? _selectedIndex;

  List<Widget> choiceChips() {
    List<Widget> chips = [];
    for (int i = 0; i < _choiceChipsList.length; i++) {
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
    switch(_selectedIndex){
      case null:
      case 2:
      case 3:
        context.read<GoogleMapModel>().RemoveItems();
        break;
      case 0:
        context.read<GoogleMapModel>().EarthQuakeItems();
        break;
      case 1:
        context.read<GoogleMapModel>().ShelterItems();
        break;
      default:
        context.read<GoogleMapModel>().RemoveItems();
        break;
    }
  }

  void onTap() {
    print("Circle Tap");
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

