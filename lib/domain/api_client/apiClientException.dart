enum ApiClientExceptionType { network, auth, other, sessionExpaired }

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}