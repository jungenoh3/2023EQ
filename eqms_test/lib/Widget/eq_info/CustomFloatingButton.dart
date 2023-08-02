import 'package:eqms_test/Api/GoogleMapModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomFloatingButton extends StatelessWidget {
  VoidCallback onMoveCamera;

  CustomFloatingButton({required this.onMoveCamera, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FloatingActionButton(onPressed: (){}, child: Icon(Icons.location_history)),
        SizedBox(height: 10,),
        FloatingActionButton(onPressed: (){
          print('pressed');
          onMoveCamera();
        }, child: Icon(Icons.refresh)),
      ],
    );
  }
}
