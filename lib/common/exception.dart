class ServerException implements Exception {
  String? message;

  ServerException({
    this.message = "Something went wrong from server, try again later",
  });
}

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);
}
