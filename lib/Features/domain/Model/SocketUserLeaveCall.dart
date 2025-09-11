class SocketUserLeaveCall {
  final String id;
  final String roomId;
  final int userId;
  final String role;
  final dynamic seatNo;
  final DateTime callLeftAt;
  final String status;
  final String name;
  final String profileImage;

  SocketUserLeaveCall({
    required this.id,
    required this.roomId,
    required this.userId,
    required this.role,
    this.seatNo,
    required this.callLeftAt,
    required this.status,
    required this.name,
    required this.profileImage,
  });

  factory SocketUserLeaveCall.fromJson(Map<String, dynamic> json) {
    return SocketUserLeaveCall(
      id: json['_id'] as String,
      roomId: json['roomId'] as String,
      userId: json['userId'] as int,
      role: json['role'] as String,
      seatNo: json['seatNo'],
      callLeftAt: DateTime.parse(json['callLeftAt'] as String),
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
      'callLeftAt': callLeftAt.toIso8601String(),
      'status': status,
      'name': name,
      'profileImage': profileImage,
    };
  }
}