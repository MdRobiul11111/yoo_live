class LeaveCallResponse {
  String? message;
  Data? data;

  LeaveCallResponse({this.message, this.data});

  LeaveCallResponse.fromJson(Map<String, dynamic> json) {
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
  String? roomId;
  int? userId;
  String? role;
  Null? seatNo;
  String? callLeftAt;
  String? status;
  String? name;
  String? profileImage;

  Data(
      {this.sId,
        this.roomId,
        this.userId,
        this.role,
        this.seatNo,
        this.callLeftAt,
        this.status,
        this.name,
        this.profileImage});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    roomId = json['roomId'];
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
    data['roomId'] = this.roomId;
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
