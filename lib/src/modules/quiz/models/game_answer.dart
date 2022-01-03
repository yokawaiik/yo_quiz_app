class GameAnswer {
  late final String text;
  late final bool isRight;

  late bool isUserAnswer;

  GameAnswer({
    required this.text,
    required this.isRight,
    this.isUserAnswer = false,
  });

  GameAnswer.fromListOfMap(Map<String, dynamic> data) {
    text = data["text"];
    isRight = data["isRight"];

    isUserAnswer = false;
  }

  void toggleSelect() {
    isUserAnswer = !isUserAnswer;
  }

  void clear() {
    isUserAnswer = false;
  }
}
