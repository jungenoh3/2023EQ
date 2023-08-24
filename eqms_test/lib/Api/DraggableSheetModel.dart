import 'package:flutter/material.dart';

// 사용 안함
class DraggableSheetModel with ChangeNotifier {
  double _draggableSheetHeight = 0;
  double get draggableSheetHeight => _draggableSheetHeight;

  void getDraggableSheetHeight(double extent){
    _draggableSheetHeight = extent;
    print('크기: $_draggableSheetHeight');
    notifyListeners();
  }

  void adjustDraggableSheetHeight(){
    if (_draggableSheetHeight == 0){
      _draggableSheetHeight = 0.11;
    }
    notifyListeners();
  }

  void resetDraggableSheetHeight(){
    _draggableSheetHeight = 0;
    notifyListeners();
  }
}