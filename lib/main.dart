import 'package:flutter/material.dart';
import 'screens/survey_page.dart';

void main() {
  runApp(SurveyApp());
}

class SurveyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Форма опитування',
      theme: ThemeData.dark(),
      home: SurveyPage(),
    );
  }
}