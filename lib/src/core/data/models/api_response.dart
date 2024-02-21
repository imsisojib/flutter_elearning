class ApiResponse{
  int statusCode;
  dynamic result;

  ApiResponse({required this.statusCode, this.result});

  @override
  String toString() {
    return 'ApiResponse{statusCode: $statusCode, result: $result}';
  }
}