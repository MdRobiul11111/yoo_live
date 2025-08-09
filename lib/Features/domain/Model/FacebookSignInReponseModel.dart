class FacebookSignInResponseModel {
  String? id;
  String? name;
  String? email;
  Picture? picture;

  FacebookSignInResponseModel({this.id, this.name, this.email, this.picture});

  FacebookSignInResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    picture =
    json['picture'] != null ?  Picture.fromJson(json['picture']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    if (this.picture != null) {
      data['picture'] = this.picture!.toJson();
    }
    return data;
  }
}

class Picture {
  Data? data;

  Picture({this.data});

  Picture.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? height;
  bool? isSilhouette;
  String? url;
  int? width;

  Data({this.height, this.isSilhouette, this.url, this.width});

  Data.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    isSilhouette = json['is_silhouette'];
    url = json['url'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['is_silhouette'] = this.isSilhouette;
    data['url'] = this.url;
    data['width'] = this.width;
    return data;
  }
}
