class Answer {
  final String id;
  String? text;
  bool isRight; 

  Answer({
    required this.id,
    this.text,
    this.isRight = false,
  });
}