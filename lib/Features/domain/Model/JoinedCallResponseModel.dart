class JoinedCallReponseModel {
  List<Data>? data;

  JoinedCallReponseModel({this.data});

  JoinedCallReponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  String? sId;
  int? userId;
  String? role;
  int? seatNo;
  String? callLeftAt;
  String? status;
  String? name;
  String? profileImage;

  Data(
      {this.sId,
        this.userId,
        this.role,
        this.seatNo,
        this.callLeftAt,
        this.status,
        this.name,
        this.profileImage});

  Data.fromJson(Map<String, dynamic> json) {
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
