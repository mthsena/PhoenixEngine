class ErrorResponseModel {
  int code;
  String message;
  Map<String, ErrorResponseIdentityModel> data;

  ErrorResponseModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> dataMap = json['data'];

    Map<String, ErrorResponseIdentityModel> identityMap = {};

    for (var entry in dataMap.entries) {
      identityMap[entry.key] = ErrorResponseIdentityModel.fromJson(entry.value);
    }

    return ErrorResponseModel(
      code: json['code'],
      message: json['message'],
      data: identityMap,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> dataMap = {};

    for (var entry in data.entries) {
      dataMap[entry.key] = entry.value.toJson();
    }

    return {
      'code': code,
      'message': message,
      'data': dataMap,
    };
  }
}

class ErrorResponseIdentityModel {
  String code;
  String message;

  ErrorResponseIdentityModel({required this.code, required this.message});

  factory ErrorResponseIdentityModel.fromJson(Map<String, dynamic> json) {
    return ErrorResponseIdentityModel(
      code: json['code'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
    };
  }
}
