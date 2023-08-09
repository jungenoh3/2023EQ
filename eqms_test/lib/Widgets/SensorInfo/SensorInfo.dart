import 'package:dio/dio.dart';
import 'package:eqms_test/Api/Retrofit/RestClient.dart';
import 'package:eqms_test/Widgets/SensorInfo/AbnorSensorList.dart';
import 'package:eqms_test/Widgets/SensorInfo/SensorList.dart';
import 'package:eqms_test/Widgets/SensorInfo/SensorTable.dart';
import 'package:flutter/material.dart';


class SensorInfo extends StatefulWidget {
  const SensorInfo({super.key});

  @override
  State<SensorInfo> createState() => _SensorInfoState();
}

class _SensorInfoState extends State<SensorInfo> with TickerProviderStateMixin {
  final dio = Dio();
  late RestClient client = RestClient(dio);
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "세부센서현황",
          style: TextStyle(color: Colors.black),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.deepOrange,
          unselectedLabelColor: Colors.black,
          labelColor: Colors.deepOrange,
          labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          tabs: const [
            Tab(
              child: Center(
                child: Text('센서 현황 리스트'),
              ),
            ),
            Tab(
              child: Center(
                child: Text('이상 센서 리스트'),
              ),
            )
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SensorList(),
          AbnorSensorList(),
        ],
      ),
    );
  }
}

