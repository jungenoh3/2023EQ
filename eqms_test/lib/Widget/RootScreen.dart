import 'package:eqms_test/widget/setting/setting.dart';
import 'package:flutter/material.dart';
import 'package:eqms_test/widget/eq_info/eq_info.dart';
import 'package:eqms_test/widget/eq_safety/eq_safety.dart';
import 'package:eqms_test/widget/sensor_info/sensor_info.dart';
import 'package:eqms_test/widget/sensor_map/sensor_map.dart';

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
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.local_activity),
          label: '지진정보지도',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_activity),
          label: '지진안전정보',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_activity),
          label: '센서지도',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_activity),
          label: '센서현황',
        ),BottomNavigationBarItem(
          icon: Icon(Icons.local_activity),
          label: '환경설정',
        ),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.deepOrange,
      onTap: onItemTapped,
    );
  }

  @override
  Widget build(BuildContext context) {
    print('RootScreen build');

    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: onItemTapped,
        children: widgetOptions,
      ),
      bottomNavigationBar: renderBottomNavigationBar(),
      extendBody: false,
      extendBodyBehindAppBar: true,
    );
  }
}
