import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

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

class SurveyPage extends StatefulWidget {
  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {

  List<String> questions = [
    "Яку останню книгу ви читали?",
    "Якого жанру вона була?",
    "Хто її автор?",
    "Чи прочитав би ти її ще раз?",
    "Чи порадиш ти її комусь?"
  ];

  int currentQuestion = 0;

  TextEditingController controller = TextEditingController();

  Future<File> _getFile() async {
    return File('/storage/emulated/0/Download/answers.txt');
  }

  Future<void> saveAnswer(String answer) async {
    final file = await _getFile();
    await file.writeAsString(
      "${questions[currentQuestion]} $answer\n",
      mode: FileMode.append,
    );
  }

  void nextQuestion() async {

    if (controller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Введіть відповідь")),
      );
      return;
    }

    await saveAnswer(controller.text);

    controller.clear();

    setState(() {
      currentQuestion++;
    });

    if (currentQuestion >= questions.length) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Опитування завершено"),
          content: Text("Відповіді збережено у файл"),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    if (currentQuestion >= questions.length) {
      return Scaffold(
        appBar: AppBar(title: Text("Опитування")),
        body: Center(
          child: Text(
            "Дякуємо за відповіді!",
            style: TextStyle(fontSize: 24),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Форма опитування")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              questions[currentQuestion],
              style: TextStyle(fontSize: 22),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 20),

            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Введіть відповідь",
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: nextQuestion,
              child: Text("Далі"),
            )

          ],
        ),
      ),
    );
  }
}