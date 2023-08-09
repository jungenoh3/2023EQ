import 'package:flutter/material.dart';

class AbnorSensorList extends StatefulWidget {
  const AbnorSensorList({super.key});

  @override
  State<AbnorSensorList> createState() => _AbnorSensorListState();
}

class _AbnorSensorListState extends State<AbnorSensorList> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "현황",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text("행정구역", style: TextStyle(fontSize: 15)),
                  const SizedBox(
                    width: 10
                  ),
                  DropdownButton(items: [], onChanged: (e) {}),
                  const SizedBox(width: 10,),
                  const Text("이상정보필터"),
                  const SizedBox(width: 10),
                  DropdownButton(items: [], onChanged: (e) {})
                ],
              ),
              Divider(color: Colors.grey[800]),
            ],
          ),
        )
      ],
    );
  }
}
