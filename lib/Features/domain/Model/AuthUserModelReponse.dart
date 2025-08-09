class AuthUserModelResponse {
  Data? data;
  String? message;

  AuthUserModelResponse({this.data, this.message});

  AuthUserModelResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? sId;
  int? userId;
  String? role;
  String? name;
  String? email;
  String? country;
  String? accessToken;
  String? refreshToken;
  String? profileImage;

  Data(
      {this.sId,
        this.userId,
        this.role,
        this.name,
        this.email,
        this.country,
        this.accessToken,
        this.refreshToken,
        this.profileImage});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    role = json['role'];
    name = json['name'];
    email = json['email'];
    country = json['country'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['role'] = this.role;
    data['name'] = this.name;
    data['email'] = this.email;
    data['country'] = this.country;
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    data['profileImage'] = this.profileImage;
    return data;
  }
}
