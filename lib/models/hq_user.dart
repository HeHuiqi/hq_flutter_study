import 'dart:convert';

class User {
  String username = '';
  String password = '';
  String? address;
  User({required this.username, required this.password, this.address});
  factory User.fromJson(String json){
    Map<String, dynamic> map = jsonDecode(json);
    print('map:$map');
    return User(username: map['username'], password: map['password'],address: map['address']);
  }
  Map<String, dynamic> toMap() {
    return {'username': username, 'password': password, 'address': address};
  }
  String toJson() {
    Map<String, dynamic> map = toMap();
    return json.encode(map);
  }
}
