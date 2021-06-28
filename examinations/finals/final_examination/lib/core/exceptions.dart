class AuthenticationException implements Exception {
  final dynamic message;

  const AuthenticationException([this.message = 'Failed to authenticate']);

  @override
  String toString() => 'AuthenticationException: $message';
}

class TodoException implements Exception {
  final dynamic message;

  const TodoException([this.message = 'Failed to process todo']);

  @override
  String toString() => 'TodoException: $message';
}
