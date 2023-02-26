String generateError(Exception e, String? error) {
  final errorOutput = error == null ? '' : ' \n$error';
  return '\n✗ ERROR: ${(e).runtimeType.toString()}$errorOutput';
}

/// Exception to be thrown whenever we have an invalid configuration
class InvalidConfigException implements Exception {
  /// Constructs instance
  const InvalidConfigException([this.message]);

  /// Message for the exception
  final String? message;

  @override
  String toString() {
    return generateError(this, message);
  }
}
