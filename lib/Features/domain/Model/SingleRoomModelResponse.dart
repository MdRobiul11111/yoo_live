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
  String? title;
  bool? isActive;
  String? category;
  int? seat;
  bool? seatLocked;
  int? callMemberCount;
  bool? private;
  String? profile;
  CreatedBy? createdBy;
  List<JoinedMembers>? joinedMembers;

  Data(
      {this.sId,
      this.title,
      this.isActive,
      this.category,
      this.seat,
      this.seatLocked,
      this.callMemberCount,
      this.private,
      this.profile,
      this.createdBy,
      this.joinedMembers});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    isActive = json['isActive'];
    category = json['category'];
    seat = json['seat'];
    seatLocked = json['seatLocked'];
    callMemberCount = json['callMemberCount'];
    private = json['private'];
    profile = json['profile'];
    createdBy = json['createdBy'] != null
        ? new CreatedBy.fromJson(json['createdBy'])
        : null;
    if (json['joinedMembers'] != null) {
      joinedMembers = <JoinedMembers>[];
      json['joinedMembers'].forEach((v) {
        joinedMembers!.add(new JoinedMembers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['isActive'] = this.isActive;
    data['category'] = this.category;
    data['seat'] = this.seat;
    data['seatLocked'] = this.seatLocked;
    data['callMemberCount'] = this.callMemberCount;
    data['private'] = this.private;
    data['profile'] = this.profile;
    if (this.createdBy != null) {
      data['createdBy'] = this.createdBy!.toJson();
    }
    if (this.joinedMembers != null) {
      data['joinedMembers'] =
          this.joinedMembers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CreatedBy {
  String? sId;
  int? userId;
  String? name;
  String? profileImage;

  CreatedBy({this.sId, this.userId, this.name, this.profileImage});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    name = json['name'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['profileImage'] = this.profileImage;
    return data;
  }
}

class JoinedMembers {
  String? sId;
  int? userId;
  String? role;
  int? seatNo;
  String? callLeftAt;
  String? status;
  String? name;
  String? profileImage;

  JoinedMembers(
      {this.sId,
      this.userId,
      this.role,
      this.seatNo,
      this.callLeftAt,
      this.status,
      this.name,
      this.profileImage});

  JoinedMembers.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    role = json['role'];
    seatNo = json['seatNo'];
    callLeftAt = json['callLeftAt'];
    status = json['status'];
    name = json['name'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['role'] = this.role;
    data['seatNo'] = this.seatNo;
    data['callLeftAt'] = this.callLeftAt;
    data['status'] = this.status;
    data['name'] = this.name;
    data['profileImage'] = this.profileImage;
    return data;
  }
}
