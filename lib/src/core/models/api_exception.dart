class ApiException with Exception {

  final String message;
  ApiException(this.message);

  @override
  String toString() {
    return message.toString();
  }

}