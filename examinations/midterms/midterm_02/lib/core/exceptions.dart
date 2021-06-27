class AuthenticationException implements Exception {
  final dynamic message;

  const AuthenticationException([this.message = 'Failed to authenticate']);

  @override
  String toString() => 'AuthenticationException: $message';
}

class TransactionException implements Exception {
  final dynamic message;

  const TransactionException([this.message = 'Failed to process transaction']);

  @override
  String toString() => 'TransactionException: $message';
}
