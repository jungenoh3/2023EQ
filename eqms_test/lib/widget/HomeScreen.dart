import 'package:eqms_test/widget/setting/setting.dart';
import 'package:flutter/material.dart';
import 'package:eqms_test/widget/eq_info/eq_info.dart';
import 'package:eqms_test/widget/eq_safety/eq_safety.dart';
import 'package:eqms_test/widget/sensor_info/sensor_info.dart';
import 'package:eqms_test/widget/sensor_map/sensor_map.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int selectedIndex = 0;
  final List<Widget> widgetOptions = <Widget>[
    EQ_Info(),
    EQ_Safety(),
    Sensor_Map(),
    Sensor_Info(),
    Setting()
  ];

  void onItemTapped(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
      ),
    );
  }
}
