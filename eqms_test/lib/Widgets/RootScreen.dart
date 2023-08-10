import 'package:eqms_test/Api/DraggableSheetModel.dart';
import 'package:eqms_test/Api/GoogleMapModel.dart';
import 'package:eqms_test/Widgets/EQInfo/EQInfo.dart';
import 'package:eqms_test/Widgets/EQSafety/EQSafety.dart';
import 'package:eqms_test/Widgets/SensorDetails/SensorDetails.dart';
import 'package:eqms_test/Widgets/SensorMap/SensorMap.dart';
import 'package:eqms_test/Widgets/Setting/Setting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin{
  final PageController _controller = PageController();
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    print('RootScreen initState');
  }

  final List<Widget> widgetOptions = <Widget>[
    EQInfo(),
    EQSafety(),
    SensorMap(),
    SensorDetails(),
    Setting()
  ];

  void onItemTapped(int index){
    if (selectedIndex != index) {
      _controller.jumpToPage(index);
      setState(() {
        selectedIndex = index;
      });
    }
  }

  BottomNavigationBar renderBottomNavigationBar(){
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/eq_info.svg'),
          activeIcon: SvgPicture.asset('assets/eq_info.svg', color: Colors.black,),
          label: '지진지도',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/eq_safety.svg'),
          activeIcon: SvgPicture.asset('assets/eq_safety_selected.svg',),
          label: '지진안전',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/sensor_map.svg'),
          activeIcon: SvgPicture.asset('assets/sensor_map.svg', color: Colors.black,),
          label: '센서지도',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/sensor_info.svg'),
          activeIcon: SvgPicture.asset('assets/sensor_info.svg', color: Colors.black,),
          label: '센서현황',
        ),BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: SvgPicture.asset('assets/setting.svg'),
          ),
          activeIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: SvgPicture.asset('assets/setting.svg', color: Colors.black,),
          ),
          label: '환경설정',
        ),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.black,
      onTap: onItemTapped,
    );
  }

  @override
  Widget build(BuildContext context) {
    print('RootScreen build');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GoogleMapModel>(create: (context) => GoogleMapModel()),
        ChangeNotifierProvider<DraggableSheetModel>(create: (context) => DraggableSheetModel())
      ],
      child: Scaffold(
        body: PageView(
          controller: _controller,
          onPageChanged: onItemTapped,
          children: widgetOptions,
        ),
        bottomNavigationBar: SizedBox(
            height: 70,
            child: renderBottomNavigationBar()),
        extendBody: false,
        extendBodyBehindAppBar: true,
      ),
    );
  }
}
