class RoomMessagesModel {
  List<RoomMessageData>? data;

  RoomMessagesModel({this.data});

  RoomMessagesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <RoomMessageData>[];
      json['data'].forEach((v) {
        data!.add(new RoomMessageData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RoomMessageData {
  String? sId;
  String? roomId;
  String? content;
  String? userId;
  String? email;
  String? name;
  String? profileImage;
  String? createdAt;

  RoomMessageData(
      {this.sId,
        this.roomId,
        this.content,
        this.userId,
        this.email,
        this.name,
        this.profileImage,
        this.createdAt});

  RoomMessageData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    roomId = json['roomId'];
    content = json['content'];
    userId = json['userId'];
    email = json['email'];
    name = json['name'];
    profileImage = json['profileImage'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['roomId'] = this.roomId;
    data['content'] = this.content;
    data['userId'] = this.userId;
    data['email'] = this.email;
    data['name'] = this.name;
    data['profileImage'] = this.profileImage;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
