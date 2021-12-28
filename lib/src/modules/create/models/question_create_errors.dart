class QuestionCreateErrors {
  final List<String> _errors = [];

  List<String> get errors => [...(_errors)];

  QuestionCreateErrors();

  @override
  String toString() {
    return _errors.join("");
  }

  void add(String error) {
    _errors.add(error);
  }
}