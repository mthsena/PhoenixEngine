class SignInResponseModel {
  String token;
  AuthResponseRecordModel record;

  SignInResponseModel({
    required this.token,
    required this.record,
  });

  factory SignInResponseModel.fromJson(Map<String, dynamic> json) {
    return SignInResponseModel(
      token: json['token'],
      record: AuthResponseRecordModel.fromJson(json['record']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'record': record.toJson(),
    };
  }
}

class AuthResponseRecordModel {
  String id;
  String collectionId;
  String collectionName;
  String username;
  String created;
  String updated;

  AuthResponseRecordModel({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.username,
    required this.created,
    required this.updated,
  });

  factory AuthResponseRecordModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseRecordModel(
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
