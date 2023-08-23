class UserData {
  int id;
  String name;
  int age;
  String mail;
  UserData(
      {required this.id,
      required this.name,
      required this.age,
      required this.mail});

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'age': age, 'mail': mail};

  static UserData fromJson(Map<String, dynamic> json) => UserData(
      id: json['id'], name: json['name'], age: json['age'], mail: json['mail']);
}
