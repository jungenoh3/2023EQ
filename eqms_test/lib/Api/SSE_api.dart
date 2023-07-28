// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class SSE {
//   final url = Uri.parse('http://155.230.118.78:1234/server-events');
//   final client = http.Client();
//
//   Future<void> getData() async {
//     try {
//       final response = await client.send(http.Request('GET', url));
//       if (response.statusCode == 200){
//         final stream = response.stream;
//         stream.transform(utf8.decoder).listen((data) {
//           print('Received data: $data');
//         }, onError: (error) {
//           print('onError occurred: $error');
//         }, cancelOnError: true
//         );
//       } else {
//         print('Request failed with status: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error occurred: $e');
//     }
//   }
//
// }