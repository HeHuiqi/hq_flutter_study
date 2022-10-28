import 'package:flutter/material.dart';
import 'package:hq_study/hq_user_info_edit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/hq_user.dart';

class HqUserInfoPage extends StatefulWidget {
  const HqUserInfoPage({super.key});

  @override
  State<HqUserInfoPage> createState() => _HqUserInfoPageState();
}

class _HqUserInfoPageState extends State<HqUserInfoPage> {
  User user = User(username: '', password: '');

  void initUser() async {
      final prefs = await SharedPreferences.getInstance();
    final userJsonInfo = prefs.getString('kUserInfo');
    print('userJsonInfo:$userJsonInfo');
    if (userJsonInfo != null) {

      setState(() {
        user = User.fromJson(userJsonInfo);

      });

    }
  }

  @override
  void initState() {
    // Obtain shared preferences.
    initUser();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UserInfo'),
        actions: [
          IconButton(
              onPressed: () async {
                List<User>? newUser =
                    await  Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return HqUserInfoEditPage(user: user);
                  },
                ));
                setState(() {
                  if (newUser != null) {
                    user = newUser[0];
                  }      
                });
              },
              icon: Icon(Icons.edit)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('username:${user.username}'),
            Text('password:${user.password}'),
          ],
        ),
      ),
    );
  }
}
