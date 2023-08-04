import 'package:flutter/material.dart';

class ScrollableSheetData {
  String? leading;
  final String title;
  final String subtitle;
  String? trailing;

  ScrollableSheetData(
      {required this.leading,
      required this.title,
      required this.subtitle,
      required this.trailing});
}
