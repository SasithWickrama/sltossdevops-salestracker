class User {
  final String username;
  final String rtom;
  final String role;
  final String sno;
  final String acccode;
  final String job;

  User(
      {this.username = "",
      this.rtom = "",
      this.role = "",
      this.sno = "",
      this.job = "",
      this.acccode = ""});

  factory User.fromJson(Map<dynamic, dynamic> parsedJson) {
    return User(
        username: parsedJson['SNO'] ?? "",
        rtom: parsedJson['RTOM'] ?? "",
        role: parsedJson['ROLE'] ?? "");
  }

  Map<dynamic, dynamic> toJson() {
    return {
      "rtom": rtom,
      "role": role,
      "username": username,
    };
  }
}
