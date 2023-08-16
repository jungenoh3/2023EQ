import 'package:dio/dio.dart';
import 'package:eqms_test/Api/Retrofit/RestClient.dart';
import 'package:eqms_test/Widgets/SensorDetails/SensorAbnormalTable.dart';
import 'package:flutter/material.dart';
import '../CommonWidgets/loading_widget.dart';

class SensorAbnormalList extends StatefulWidget {
  const SensorAbnormalList({super.key});

  @override
  State<SensorAbnormalList> createState() => _SensorAbnormalListState();
}

class _SensorAbnormalListState extends State<SensorAbnormalList> {
  final dio = Dio();
  late RestClient client = RestClient(dio);
  String abnormalValue = "전체";
  String regionValue = "전체";
  List<String> regionData = [];
  List<String> abnormalData = [
    "전체",
    "가속도",
    "기압계",
    "온도계",
    "Fault Message"
  ];
  final queryParameter = Map<String, String>();

  @override
  void initState() {
    super.initState();

    client.getSensorAbnormalRegion().then((value) {
      setState(() {
        regionData = value;
        regionData.insert(0, "전체");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: client.getSensorAbnormalSearch(queryParameter),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData){

            print(queryParameter);

            return Wrap(
              direction: Axis.horizontal,
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "현황",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text("행정구역", style: TextStyle(fontSize: 15)),
                          const SizedBox(width: 10),
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
                                if (value! == '전체' &&
                                    queryParameter.keys.contains('region')) {
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
                          const Text("이상정보필터"),
                          const SizedBox(width: 10),
                          Container(
                            width: 75,
                            child: DropdownButton(
                              isExpanded: true,
                              value: abnormalValue,
                              items: abnormalData
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  abnormalValue = value!;
                                  String? regionValue = queryParameter["region"];
                                  queryParameter.clear();
                                  if (regionValue != null) {
                                    queryParameter["region"] = regionValue;
                                  }
                                  if (value! != '전체') {
                                    switch (value!) {
                                      case "가속도":
                                        queryParameter["accelerator"] = "Y";
                                        break;
                                      case "기압계":
                                        queryParameter["pressure"] = "Y";
                                        break;
                                      case "온도계":
                                        queryParameter["temperature"] = "Y";
                                        break;
                                      case "Fault Message":
                                        queryParameter["fault_message"] = "Y";
                                        break;
                                    }
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.grey[400]),
                      SensorAbnormalTable(sensorValue: snapshot.data),
                    ],
                  ),
                )
              ],
            );
          }
          return LoadingIndicator();
        });
  }

  List<String> getRegionButtonItems(List<SensorAbnormal> value) {
    List<String> regions =
        value.map((e) => e.region).toSet().toList(growable: true);
    regions.insert(0, "전체");
    return regions;
  }
}
