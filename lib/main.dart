import 'package:flutter/material.dart';
import 'pages/curso_estadisticas.dart';

void main() {
  runApp(CourseStatsApp());
}

class CourseStatsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CourseStatsScreen(),
    );
  }
}
