class User{
  String id;
  String firstName;
  String lastName;
  String userName;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.userName,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json['id'],
    firstName: json['first_name'],
    lastName: json['last_name'],
    userName: json['username'],
  );
}