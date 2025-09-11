class SocketUserJoinedCall {
  final String id;
  final String roomId;
  final int userId;
  final String role;
  final int seatNo;
  final DateTime callJoinedAt;
  final String status;
  final String name;
  final String profileImage;

  SocketUserJoinedCall({
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

  factory SocketUserJoinedCall.fromJson(Map<String, dynamic> json) {
    return SocketUserJoinedCall(
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