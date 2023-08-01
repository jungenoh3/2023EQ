import 'package:eqms_test/Api/GoogleMapModel.dart';
import 'package:eqms_test/widget/setting/setting.dart';
import 'package:flutter/material.dart';
import 'package:eqms_test/widget/eq_info/eq_info.dart';
import 'package:eqms_test/widget/eq_safety/eq_safety.dart';
import 'package:eqms_test/widget/sensor_info/sensor_info.dart';
import 'package:eqms_test/widget/sensor_map/sensor_map.dart';
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
    EQ_Info(),
    EQ_Safety(),
    Sensor_Map(),
    Sensor_Info(),
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
          activeIcon: SvgPicture.asset('assets/eq_safety.svg', color: Colors.black,),
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
    return ChangeNotifierProvider(
      create: (context) => GoogleMapModel(),
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
