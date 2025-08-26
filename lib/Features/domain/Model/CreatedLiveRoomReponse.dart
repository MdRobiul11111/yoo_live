class CreatedLiveRoomResponse {
  String? message;
  List<Data>? data;

  CreatedLiveRoomResponse({this.message, this.data});

  CreatedLiveRoomResponse.fromJson(Map<String, dynamic> json) {
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
  String? sId;
  String? createdBy;
  String? title;
  String? category;
  int? seat;
  bool? seatLocked;
  int? callMemberCount;
  bool? private;
  String? password;
  String? profile;
  int? iV;
  bool? isActive;

  Data(
      {this.sId,
        this.createdBy,
        this.title,
        this.category,
        this.seat,
        this.seatLocked,
        this.callMemberCount,
        this.private,
        this.password,
        this.profile,
        this.iV,
        this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    createdBy = json['createdBy'];
    title = json['title'];
    category = json['category'];
    seat = json['seat'];
    seatLocked = json['seatLocked'];
    callMemberCount = json['callMemberCount'];
    private = json['private'];
    password = json['password'];
    profile = json['profile'];
    iV = json['__v'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = this.sId;
    data['createdBy'] = this.createdBy;
    data['title'] = this.title;
    data['category'] = this.category;
    data['seat'] = this.seat;
    data['seatLocked'] = this.seatLocked;
    data['callMemberCount'] = this.callMemberCount;
    data['private'] = this.private;
    data['password'] = this.password;
    data['profile'] = this.profile;
    data['__v'] = this.iV;
    data['isActive'] = this.isActive;
    return data;
  }
}
