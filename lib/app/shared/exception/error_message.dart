class ErrorMessage implements Exception {
  String message;

  ErrorMessage(this.message);

  String toString() {
    return message;
  }
}