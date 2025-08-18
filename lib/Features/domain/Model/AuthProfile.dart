class AuthProfile {
  String? message;
  Data? data;

  AuthProfile({this.message, this.data});

  AuthProfile.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? userId;
  String? name;
  String? country;
  String? role;
  String? profileImage;

  Data({this.userId, this.name, this.country, this.role, this.profileImage});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    country = json['country'];
    role = json['role'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['country'] = this.country;
    data['role'] = this.role;
    data['profileImage'] = this.profileImage;
    return data;
  }
}
