class SignInResponseModel {
  String token;
  AuthResponseModel record;

  SignInResponseModel({
    required this.token,
    required this.record,
  });

  factory SignInResponseModel.fromJson(Map<String, dynamic> json) {
    return SignInResponseModel(
      token: json['token'],
      record: AuthResponseModel.fromJson(json['record']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'record': record.toJson(),
    };
  }
}

class AuthResponseModel {
  String id;
  String collectionId;
  String collectionName;
  String username;
  String created;
  String updated;

  AuthResponseModel({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.username,
    required this.created,
    required this.updated,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      id: json['id'],
      collectionId: json['collectionId'],
      collectionName: json['collectionName'],
      username: json['username'],
      created: json['created'],
      updated: json['updated'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'collectionId': collectionId,
      'collectionName': collectionName,
      'username': username,
      'created': created,
      'updated': updated,
    };
  }
}
