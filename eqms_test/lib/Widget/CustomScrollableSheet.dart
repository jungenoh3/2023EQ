import 'package:eqms_test/Api/GoogleMapModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomScrollableSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("sheetItems length: ${context.watch<GoogleMapModel>().sheetItems.length}");

    return Visibility(
      visible: context.watch<GoogleMapModel>().sheetItems.isNotEmpty,
      maintainState: false,
      child: DraggableScrollableSheet(
          initialChildSize: 0.12,
          minChildSize: 0.05,
          builder:
              (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: ListView.separated(
                physics: ClampingScrollPhysics(),
                controller: scrollController,
                separatorBuilder: (BuildContext context, int index) => const Divider(),
                itemCount: context.watch<GoogleMapModel>().sheetItems.length,
                itemBuilder: (BuildContext context, int index) {
                  final data = context.watch<GoogleMapModel>().sheetItems[index];
                  if (index == 0) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            height: 5,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(16)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.alarm),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                context.watch<GoogleMapModel>().sheetTitle,
                                style: TextStyle(fontSize: 20),
                              ),
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
                      title: Text(data.id),
                      trailing: Text(data.description),
                    ),
                  );
                },
              ),
            );
          }),
    );
  }

}