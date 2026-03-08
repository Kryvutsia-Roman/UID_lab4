import 'dart:io';

class FileService {
  static Future<File> _getFile() async {
    return File('/storage/emulated/0/Download/answers.txt');
  }

  static Future<void> saveAnswer(String question, String answer) async {
    final file = await _getFile();
    await file.writeAsString(
      "$question: $answer\n",
      mode: FileMode.append,
    );
  }
}