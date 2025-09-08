class SocketMessageModel {
  String? sId;
  String? roomId;
  String? content;
  String? email;
  String? userId;
  String? name;
  String? profileImage;
  String? createdAt;

  SocketMessageModel(
      {this.sId,
        this.roomId,
        this.content,
        this.email,
        this.userId,
        this.name,
        this.profileImage,
        this.createdAt});

  SocketMessageModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    roomId = json['roomId'];
    content = json['content'];
    email = json['email'];
    userId = json['userId'];
    name = json['name'];
    profileImage = json['profileImage'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['roomId'] = this.roomId;
    data['content'] = this.content;
    data['email'] = this.email;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['profileImage'] = this.profileImage;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
