class UnknownException with Exception {

  final String message;
  UnknownException(this.message);

  @override
  String toString() {
    return message.toString();
  }

}