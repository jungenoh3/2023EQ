import 'dart:math';

import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class SensorList extends StatefulWidget {
  const SensorList({super.key});

  @override
  State<SensorList> createState() => _SensorListState();
}

class _SensorListState extends State<SensorList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Colors.deepOrange)),
                      hintText: '단말번호를 입력해주세요.'),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () {},
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
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "조회현황",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text("행정구역", style: TextStyle(fontSize: 15)),
                  const SizedBox(
                    width: 10,
                  ),
                  DropdownButton(
                    value: "전체",
                    items: buttonItems
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {},
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text("시설"),
                  const SizedBox(
                    width: 10,
                  ),
                  DropdownButton(
                    value: "전체",
                    items: buttonItems
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {},
                  ),
                ],
              ),
              Divider(color: Colors.grey[800]),
              // PaginatedDataTable(
              //   source: MyData(),
              //   columns: const [
              //     DataColumn(label: Text('ID')),
              //     DataColumn(label: Text('Name')),
              //     DataColumn(label: Text('Price'))
              //   ],
              //   columnSpacing: 100,
              //   horizontalMargin: 10,
              //   rowsPerPage: 5,
              //   showCheckboxColumn: false,
              // ),
            ],
          ),
        ),
      ],
    );
  }
}

List<String> buttonItems = ["전체", "A", "B", "C", "D"];

// final List<Map<String, dynamic>> _data = List.generate(
//     200,
//     (index) => {
//           "id": index,
//           "title": "Item $index",
//           "price": Random().nextInt(10000)
//         });
//
// // The "soruce" of the table
// class MyData extends DataTableSource {
//   // Generate some made-up data
//   final List<Map<String, dynamic>> _data = List.generate(
//       200,
//       (index) => {
//             "id": index,
//             "title": "Item $index",
//             "price": Random().nextInt(10000)
//           });
//
//   @override
//   bool get isRowCountApproximate => false;
//   @override
//   int get rowCount => _data.length;
//   @override
//   int get selectedRowCount => 0;
//   @override
//   DataRow getRow(int index) {
//     return DataRow(cells: [
//       DataCell(Text(_data[index]['id'].toString())),
//       DataCell(Text(_data[index]["title"])),
//       DataCell(Text(_data[index]["price"].toString())),
//     ]);
//   }
// }
