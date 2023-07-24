import 'package:dio/dio.dart';
import 'package:eqms_test/Api/Retrofit/RestClient.dart';
import 'package:flutter/material.dart';

class Sensor_Info extends StatefulWidget {
  const Sensor_Info({super.key});

  @override
  State<Sensor_Info> createState() => _Sensor_InfoState();
}

class _Sensor_InfoState extends State<Sensor_Info> {
  late RestClient client;

  @override
  void initState() {
    super.initState();

    final dio = Dio();

    client = RestClient(dio);
    // Future.microtask(() async {
    //   final resp = await client.getSensorInformation();
    //   print('microstack check');
    //   print(resp);
    // });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: client.getSensorInformation(),
        builder: (context, snapshot) {
          if (snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      children: [
                        Text(snapshot.data![index].deviceid),
                        Text(snapshot.data![index].address),
                        Text(snapshot.data![index].longitude.toString()),
                        Text(snapshot.data![index].latitude.toString()),
                      ],
                    ),
                  );
                });
          }
          else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }

}
