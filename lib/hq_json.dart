import 'dart:convert';

import 'package:flutter/material.dart';


class _User {
  final String name;
  final String? email;
  _User(this.name,this.email);
  factory _User.fromJson(Map<String,dynamic> json) {
    return _User(json['name'], json['email']);
  }
  Map<String,dynamic> toJson(){
    return {
      'name':name,
      'email':email,
    };
  }
    
}
class HqJsonPage extends StatelessWidget {
   HqJsonPage({super.key});

  final String json = '{"name":"hq","age":10,"email":"1710310@qq.com"}';


  @override
  Widget build(BuildContext context) {
    final Map<String,dynamic> dic = jsonDecode(json);
    print('dic:${dic}');
    _User u = _User.fromJson(dic);
    print('user:${u.toJson()}');

    String uJson = jsonEncode(u);
    print('$uJson');

    return Scaffold(
      appBar: AppBar(
        title: Text('HqJson'),
      ),
      body: Center(
        child: Text('$json'),
      ),
    );
  }
}
