class SeatSwitchedEvent {
  final String message;
  final SocketUserSwitchSeat data;

  SeatSwitchedEvent({
    required this.message,
    required this.data,
  });

  factory SeatSwitchedEvent.fromJson(Map<String, dynamic> json) {
    return SeatSwitchedEvent(
      message: json['message'] as String,
      data: SocketUserSwitchSeat.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
    };
  }
}

class SocketUserSwitchSeat {
  final String id;
  final String roomId;
  final int userId;
  final String role;
  final int seatNo;
  final DateTime callJoinedAt;
  final String status;
  final String name;
  final String profileImage;

  SocketUserSwitchSeat({
    required this.id,
    required this.roomId,
    required this.userId,
    required this.role,
    required this.seatNo,
    required this.callJoinedAt,
    required this.status,
    required this.name,
    required this.profileImage,
  });

  factory SocketUserSwitchSeat.fromJson(Map<String, dynamic> json) {
    return SocketUserSwitchSeat(
      id: json['_id'] as String,
      roomId: json['roomId'] as String,
      userId: json['userId'] as int,
      role: json['role'] as String,
      seatNo: json['seatNo'] as int,
      callJoinedAt: DateTime.parse(json['callJoinedAt'] as String),
      status: json['status'] as String,
      name: json['name'] as String,
      profileImage: json['profileImage'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'roomId': roomId,
      'userId': userId,
      'role': role,
      'seatNo': seatNo,
      'callJoinedAt': callJoinedAt.toIso8601String(),
      'status': status,
      'name': name,
      'profileImage': profileImage,
    };
  }
}