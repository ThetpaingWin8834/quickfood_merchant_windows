class User {
  final String? accessToken;
  final String? refreshToken;
  final String? userId;
  final String? userName;
  final String? email;
  final String? phoneNumber;
  final String? fullName;
  final String? userRole;
  User({
    this.accessToken,
    this.refreshToken,
    this.userId,
    this.userName,
    this.email,
    this.phoneNumber,
    this.fullName,
    this.userRole,
  });

  User copyWith({
    String? accessToken,
    String? refreshToken,
    String? userId,
    String? userName,
    String? email,
    String? phoneNumber,
    String? fullName,
    String? userRole,
  }) {
    return User(
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
        userId: userId ?? this.userId,
        userName: userName ?? this.userName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        fullName: fullName ?? this.fullName,
        userRole: userRole ?? this.userRole);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'userId': userId,
      'userName': userName,
      'email': email,
      'phoneNumber': phoneNumber,
      'fullName': fullName,
      'userRole': userRole,
    };
  }

  @override
  String toString() {
    return 'User(accessToken: $accessToken, refreshToken: $refreshToken, userId: $userId, userName: $userName, email: $email, phoneNumber: $phoneNumber, fullName: $fullName, userRole: $userRole,)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.accessToken == accessToken &&
        other.refreshToken == refreshToken &&
        other.userId == userId &&
        other.userName == userName &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.fullName == fullName;
  }

  @override
  int get hashCode {
    return accessToken.hashCode ^
        refreshToken.hashCode ^
        userId.hashCode ^
        userName.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        fullName.hashCode;
  }
}
