class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  String get message => _message;

  String get pefix => _prefix;

  String toString() => "$_prefix : $_message";
}

class FetchDataException extends AppException {
  FetchDataException([String message])
      : super(message, "Error During Communication");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised");
}

class InvalidInputException extends AppException {
  InvalidInputException([String message]) : super(message, "Invalid Input");
}

class NotFoundException extends AppException {
  NotFoundException([String message]) : super(message, "Not Found");
}

class ConflictException extends AppException {
  ConflictException([String message]) : super(message, "Conflict");
}

class ForbiddenException extends AppException {
  ForbiddenException([String message]) : super(message, "Forbidden");
}
