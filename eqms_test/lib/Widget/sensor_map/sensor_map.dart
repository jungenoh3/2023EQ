import 'package:dio/dio.dart';
import 'package:eqms_test/Api/Retrofit/RestClient.dart';
import 'package:eqms_test/Widget/google_map/google_map.dart';
import 'package:eqms_test/Widget/google_map/models/MapItems.dart';
import 'package:flutter/material.dart';
import 'package:eqms_test/Widget/google_map/models/EnumGoogleMap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Sensor_Map extends StatefulWidget {
  const Sensor_Map({super.key});

  @override
  State<Sensor_Map> createState() => _Sensor_MapState();
}

class _Sensor_MapState extends State<Sensor_Map> {
  final dio = Dio();
  late RestClient client = RestClient(dio);
  List<Circle> circleItems = [];
  List<ClusterData> markerItems = [];
  List<SensorInfo> sensorItems = [];


  @override
  void initState() {
    super.initState();
    fetchClusterData();
    print('Sensor_map initState');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Google_Map(
                mode: GoogleMapMode.sensor,
                circleItems: circleItems,
                markerItems: markerItems),
            DraggableScrollableSheet(
                initialChildSize: 0.12,
                minChildSize: 0.05,
                builder: (BuildContext context, ScrollController scrollController){
                  return Container(
                    color: Colors.white,
                    child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      controller: scrollController,
                      itemCount: sensorItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        final data = sensorItems[index];
                        if( index == 0 ){
                          return Column(
                            children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                height: 5,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(16)
                                ),
                              ),
                            ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.alarm),
                                    SizedBox(width: 8,),
                                    Text("센서", style: TextStyle(fontSize: 20),),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                        return Card(
                            elevation: 0,
                            child: ListTile(
                              contentPadding: EdgeInsets.all(10),
                              title: Text(data.deviceid),
                              trailing: Text(data.address),
                            ),
                          );
                      },
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  void fetchClusterData(){
    client.getSensorInformation().then((value) {
      if(value.isNotEmpty){
        setState(() {
          markerItems = [
            for (int i=0; i<value.length; i++)
              ClusterData(
                  id: value[i].id.toString(),
                  latLng: LatLng(value[i].latitude, value[i].longitude),
                  address: value[i].address)
          ];
          sensorItems = value;
          sensorItems.insert(0, SensorInfo(id: -1, deviceid: "_", latitude: 0, longitude: 0, address: "_", manu_comp: "_", level: "_"));
        });
      }
    });
  }

}