import 'package:flutter/material.dart';
import '../models/survey_model.dart';
import '../services/file_service.dart';

class SurveyPage extends StatefulWidget {
  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  int currentQuestion = 0;
  TextEditingController controller = TextEditingController();

  void nextQuestion() async {
    if (controller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Введіть відповідь")),
      );
      return;
    }

    await FileService.saveAnswer(SurveyModel.questions[currentQuestion], controller.text);

    controller.clear();

    setState(() {
      currentQuestion++;
    });

    if (currentQuestion >= SurveyModel.questions.length) {
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
    if (currentQuestion >= SurveyModel.questions.length) {
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
              SurveyModel.questions[currentQuestion],
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