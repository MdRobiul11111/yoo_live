class SingleRoomResponse {
  String? message;
  Data? data;

  SingleRoomResponse({this.message, this.data});

  SingleRoomResponse.fromJson(Map<String, dynamic> json) {
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
  String? sId;
  String? createdBy;
  String? title;
  bool? isActive;
  String? category;
  int? seat;
  bool? seatLocked;
  int? callMemberCount;
  bool? private;
  Null? password;
  String? profile;
  int? iV;

  Data(
      {this.sId,
        this.createdBy,
        this.title,
        this.isActive,
        this.category,
        this.seat,
        this.seatLocked,
        this.callMemberCount,
        this.private,
        this.password,
        this.profile,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
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
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
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
    data['__v'] = this.iV;
    return data;
  }
}
