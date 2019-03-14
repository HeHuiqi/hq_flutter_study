import 'package:flutter/material.dart';


import './hq_counter.dart';
import './hq_my_appbar.dart';
import './hq_list_word.dart';
import './hq_drawer.dart';
import './hq_login_page.dart';
void main(){
  runApp(HqLoginApp());
}

class HqAMainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "123",
      home: HqInputWidget(),
    );
  }
}
class HqInputWidget extends StatefulWidget {
  @override
  _HqInputWidgetState createState() => _HqInputWidgetState();
}

class _HqInputWidgetState extends State<HqInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Test'),),
      body: Container(
        child: SingleChildScrollView(
          child: Row(
          children: <Widget>[
            Text('用户'),
            Container(
              width: 100,
              child: TextField(decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),),
            ),
          ],
        ),
        )
      ),
    );
  }
}








