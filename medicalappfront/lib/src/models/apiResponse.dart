class ApiResponse {
  int status;
  String message;
  Object data;

  ApiResponse({this.status, this.message, this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
        status: json['statusCode'],
        message: json['message'],
        data: json['data']);
  }

  Map<String, dynamic> toJson() => {"status": status, "data": data};
}