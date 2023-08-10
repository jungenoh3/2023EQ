import 'package:dio/dio.dart';
import 'package:eqms_test/Api/Retrofit/RestClient.dart';
import 'package:eqms_test/Widgets/SensorDetails/SensorInfoTable.dart';
import 'package:flutter/material.dart';

class SensorInfoList extends StatefulWidget {
  const SensorInfoList({super.key});

  @override
  State<SensorInfoList> createState() => _SensorInfoListState();
}

class _SensorInfoListState extends State<SensorInfoList> {
  final dio = Dio();
  late RestClient client = RestClient(dio);
  String facilityValue = "전체";
  String regionValue = "전체";
  final queryParameter = Map<String, String>();
  final myController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: client.getSensorSearch(queryParameter),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          List<String> facilityData = getFacilityButtonItems(snapshot.data);
          List<String> regionData = getRegionButtonItems(snapshot.data);

          print('길이: ${snapshot.data.length}');
          print('쿼리파라미터 ${queryParameter}');

          return Wrap(
            direction: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        controller: myController,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2, color: Colors.deepOrange)),
                            hintText: '단말번호를 입력해주세요.'),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                        height: 48,
                        child: OutlinedButton(
                          onPressed: () {
                              setState(() {
                                if (myController.text.isNotEmpty){
                                  queryParameter['deviceid'] = myController.text;
                                } else if (queryParameter.keys.contains('deviceid')){
                                  queryParameter.remove('deviceid');
                                }
                              });
                          },
                          child: Text("조회"),
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                              foregroundColor: Colors.white),
                        ))
                  ],
                ),
              ),
              const Divider(
                color: Colors.grey,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "조회현황",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text("행정구역", style: TextStyle(fontSize: 15)),
                        const SizedBox(
                          width: 10,
                        ),
                        DropdownButton(
                          value: regionValue,
                          items: regionData
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              regionValue = value!;
                              if (value! == '전체' && queryParameter.keys.contains('region')){
                                queryParameter.remove('region');
                              } else {
                                queryParameter['region'] = value;
                              }
                            });
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text("시설"),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 75,
                          child: DropdownButton(
                            isExpanded: true,
                              value: facilityValue,
                              style: TextStyle(color: Colors.black, fontSize: 14),
                              items: facilityData
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  facilityValue = value!;
                                  if (value! == '전체' && queryParameter.keys.contains('facility')){
                                    queryParameter.remove('facility');
                                  } else {
                                    queryParameter['facility'] = value;
                                  }
                                });
                              },
                          ),
                        ),
                      ],
                    ),
                    Divider(color: Colors.grey[800]),
                    SensorInfoTable(
                      sensorValue: snapshot.data,
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  List<String> getFacilityButtonItems(List<SensorInfo> value) {
    List<String> facility = value
        .where((element) => element.facility != null)
        .map((e) => e.facility!)
        .toSet()
        .toList(growable: true);
    facility.insert(0, "전체");
    return facility;
  }

  List<String> getRegionButtonItems(List<SensorInfo> value){
    List<String> regions = value.map((e) => e.region).toSet().toList(growable: true);
    regions.insert(0, "전체");
    return regions;
  }

}