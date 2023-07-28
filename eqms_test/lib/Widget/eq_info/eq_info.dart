import 'package:eqms_test/Widget/google_map/models/GoogleMapMode.dart';
import 'package:eqms_test/Widget/google_map/google_map.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class EQ_Info extends StatefulWidget {
  const EQ_Info({super.key});

  @override
  State<EQ_Info> createState() => _EQ_InfoState();
}

class _EQ_InfoState extends State<EQ_Info> with AutomaticKeepAliveClientMixin {
  GoogleMapMode mode = GoogleMapMode.shelter;
  final url = Uri.parse('http://155.230.118.78:1234/server-events');
  final client = http.Client();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getServerData();
    print('EQ_Info initState');
  }

  @override
  void dispose() {
    client.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 10, right: 20), // 임시 줄 맞추기
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ActionChip(
              label: Text('지진 정보'),
              onPressed: () {
                setState(() {
                  if (mode != GoogleMapMode.EQinfo) mode = GoogleMapMode.EQinfo;});
                }),
            const SizedBox(width: 10),
            ActionChip(
              label: Text('대피소 정보'),
              onPressed: () {
                setState(() {
                  if (mode != GoogleMapMode.shelter) mode = GoogleMapMode.shelter;});
                }),
            const SizedBox(width: 10),
            ActionChip(
              label: Text('내진 설계'),
              onPressed: () {
                setState(() {
                  if (mode != GoogleMapMode.empty) mode = GoogleMapMode.empty;
                });
              },
            ),
          ],
        ),
      ),
      body: Google_Map(mode: mode,),
    );
  }

  Future<void> getServerData() async {
    try {
      final response = await client.send(http.Request('GET', url));
      if (response.statusCode == 200){
        final stream = response.stream;
        stream.transform(utf8.decoder).listen((data) {
          if (data.contains("Earthquake")){
            setState(() {
              mode = GoogleMapMode.EQupdate;
            });
          }
          print('Received data: $data');
        }, onError: (error) {
          print('onError occurred: $error');
        }, cancelOnError: true);
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}