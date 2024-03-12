class UserModel {
  String userId, email,  date,name,  token;
  String? imageUrl , password;
  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.password,
    required this.date,
    this.imageUrl,
    required this.token,
  });

  toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'password': password,
      'date': date,
      'imageUrl': imageUrl,
      'token': token,
    };
  }

  factory UserModel.fromJson(Map userRow) {
    return UserModel(
        userId: userRow['userId'],
        name: userRow['name'],
        email: userRow['email'],
        password: userRow['password'],
        date: userRow['date'],
        imageUrl: userRow['imageUrl'],
        token: userRow['token']);
  }
}
