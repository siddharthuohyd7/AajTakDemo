class AppException implements Exception {
  late final _message;
  late final _prefix;

  AppException(this._message, this._prefix);

  @override
  String toString() {
    if(_prefix.toString().isNotEmpty) {
      return "$_prefix$_message";
    } else {
      return _message;
    }
  }
}

class FetchDataException extends AppException {
  FetchDataException(String message)
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException(message) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException(message) : super(message, "Unauthorised: ");
}

class ServerException extends AppException {
  ServerException(message) : super(message, "Internal Server Error: ");
}

class InvalidInputException extends AppException {
  InvalidInputException(String message) : super(message, "Invalid Input: ");
}

class PasswordChangeRequiredException extends AppException {
  PasswordChangeRequiredException(String message) : super(message, "");
}
