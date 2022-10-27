class DataBaseException implements Exception {
  final String message;
  DataBaseException(this.message);
  @override
  String toString() => message;
}

class ConnectionException implements Exception {
  final String? message;
  ConnectionException({this.message});
}

class HttpException implements Exception {
  final String? message;
  final dynamic status;

  HttpException(this.status, this.message);

  @override
  String toString() {
    return "$status $message";
  }
}

class ServerError implements Exception {
  final String? message;
  final int status;

  ServerError(this.status, this.message);

  @override
  String toString() {
    return "$status $message";
  }
}

class BadRequestException implements Exception {
  final String? message;
  final int status;

  BadRequestException(this.message, this.status);

  @override
  String toString() {
    return "$status $message";
  }
}
