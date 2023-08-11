import 'package:eqms_test/Api/DraggableSheetModel.dart';
import 'package:eqms_test/Api/GoogleMapModel.dart';
import 'package:eqms_test/Widgets/EQInfo/EQInfo.dart';
import 'package:eqms_test/Widgets/EQSafety/EQSafety.dart';
import 'package:eqms_test/Widgets/SensorDetails/SensorDetails.dart';
import 'package:eqms_test/Widgets/SensorMap/SensorMap.dart';
import 'package:eqms_test/Widgets/MorePage/more_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  late final PageController _controller;
  int selectedIndex = 0;

  final List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: SvgPicture.asset('assets/eq_info.svg'),
      activeIcon: SvgPicture.asset('assets/eq_info_selected.svg'),
      label: '지진지도',
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset('assets/eq_safety.svg'),
      activeIcon: SvgPicture.asset('assets/eq_safety_selected.svg'),
      label: '지진안전',
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset('assets/sensor_map.svg'),
      activeIcon: SvgPicture.asset('assets/sensor_map_selected.svg'),
      label: '센서지도',
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset('assets/sensor_info.svg'),
      activeIcon: SvgPicture.asset('assets/sensor_info_selected.svg'),
      label: '센서현황',
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset('assets/setting.svg'),
      activeIcon: SvgPicture.asset('assets/setting_selected.svg'),
      label: '더보기',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();  // Dispose of the controller when not needed
    super.dispose();
  }

  void onItemTapped(int index) {
    if (selectedIndex != index) {
      _controller.jumpToPage(index);
      setState(() => selectedIndex = index);
    }
  }

  BottomNavigationBar renderBottomNavigationBar() {
    return BottomNavigationBar(
      elevation: 0,
      items: bottomItems,
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.black,
      onTap: onItemTapped,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      const EQInfo(),
      const EQSafety(),
      const SensorMap(),
      const SensorDetails(),
      const MorePage(),
    ];

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GoogleMapModel>(create: (context) => GoogleMapModel()),
        ChangeNotifierProvider<DraggableSheetModel>(create: (context) => DraggableSheetModel()),
      ],
      child: Scaffold(
        body: PageView(
          controller: _controller,
          onPageChanged: onItemTapped,
          children: widgetOptions,
        ),
        bottomNavigationBar: SafeArea(
          child: SizedBox(
              height: 58,
              child: renderBottomNavigationBar()),
        ),
        extendBody: false,
        extendBodyBehindAppBar: true,
      ),
    );
  }
}