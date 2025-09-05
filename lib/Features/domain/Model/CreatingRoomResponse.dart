import 'dart:io';

class CreatingRoomResponse {
  String? message;
  Data? data;

  CreatingRoomResponse({this.message, this.data});

  CreatingRoomResponse.fromJson(Map<String, dynamic> json) {
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
  String? createdBy;
  String? title;
  bool? isActive;
  String? category;
  int? seat;
  bool? seatLocked;
  int? callMemberCount;
  bool? private;
  String? password;
  String? profile;
  String? sId;
  int? iV;

  Data(
      {this.createdBy,
        this.title,
        this.isActive,
        this.category,
        this.seat,
        this.seatLocked,
        this.callMemberCount,
        this.private,
        this.password,
        this.profile,
        this.sId,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    createdBy = json['createdBy'];
    title = json['title'];
    isActive = json['isActive'];
    category = json['category'];
    seat = json['seat'];
    seatLocked = json['seatLocked'];
    callMemberCount = json['callMemberCount'];
    private = json['private'];
    password = json['password'];
    profile = json['profile'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdBy'] = this.createdBy;
    data['title'] = this.title;
    data['isActive'] = this.isActive;
    data['category'] = this.category;
    data['seat'] = this.seat;
    data['seatLocked'] = this.seatLocked;
    data['callMemberCount'] = this.callMemberCount;
    data['private'] = this.private;
    data['password'] = this.password;
    data['profile'] = this.profile;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}


class DataForRoom {
  String title;
  String category;
  int seat;
  File? imageFilePath;

  DataForRoom(this.title, this.category, this.seat, this.imageFilePath);
}
