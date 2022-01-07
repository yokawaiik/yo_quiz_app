import 'package:uuid/uuid.dart';

class Answer {
  late final String id;
  late String? text;
  late bool isRight;

  Answer({
    required this.id,
    this.text,
    this.isRight = false,
  });

  Answer.fromMap(Map<String, dynamic> data) {
    id = const Uuid().v1();
    text = data["text"];
    isRight = data["isRight"];
  }
}
