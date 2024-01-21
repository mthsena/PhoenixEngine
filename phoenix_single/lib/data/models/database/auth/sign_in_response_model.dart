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
  bool verified;
  bool emailVisibility;
  String email;
  String created;
  String updated;
  String name;
  String avatar;

  AuthResponseRecordModel({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.username,
    required this.verified,
    required this.emailVisibility,
    required this.email,
    required this.created,
    required this.updated,
    required this.name,
    required this.avatar,
  });

  factory AuthResponseRecordModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseRecordModel(
      id: json['id'],
      collectionId: json['collectionId'],
      collectionName: json['collectionName'],
      username: json['username'],
      verified: json['verified'],
      emailVisibility: json['emailVisibility'],
      email: json['email'],
      created: json['created'],
      updated: json['updated'],
      name: json['name'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'collectionId': collectionId,
      'collectionName': collectionName,
      'username': username,
      'verified': verified,
      'emailVisibility': emailVisibility,
      'email': email,
      'created': created,
      'updated': updated,
      'name': name,
      'avatar': avatar,
    };
  }
}
