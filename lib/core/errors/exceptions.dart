class ServerException implements Exception {
  String messaage;
  ServerException({
    this.messaage = '',
  });
}

class CacheException implements Exception {
  String message;
  CacheException({
    this.message = '',
  });
}
