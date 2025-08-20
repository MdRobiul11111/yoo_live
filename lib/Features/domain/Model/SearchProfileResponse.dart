class SearchProfileResponse {
  String? message;
  List<Data>? data;

  SearchProfileResponse({this.message, this.data});

  SearchProfileResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? userId;
  String? name;
  String? role;
  String? country;
  String? profileImage;

  Data({this.userId, this.name, this.role, this.country, this.profileImage});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    role = json['role'];
    country = json['country'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['role'] = this.role;
    data['country'] = this.country;
    data['profileImage'] = this.profileImage;
    return data;
  }
}
