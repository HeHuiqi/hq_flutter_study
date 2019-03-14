import 'package:flutter/material.dart';

class HqDetailPage extends StatelessWidget{
  @override
    Widget build(BuildContext context) {
      String title;
      return new Scaffold(
        appBar: AppBar(
          title: new Text('详情'),
          leading: IconButton(icon: new Icon(Icons.arrow_back),onPressed: (){
            Navigator.pop(context);
          },),
        ),
        body: new Center(
          child: new Column(
          children: <Widget>[
            new Padding(padding: new EdgeInsets.only(top:10),),
            new Text(title ?? "详情页面",style: TextStyle(color: Colors.red),),
            new Padding(padding: new EdgeInsets.only(top:10),),
            new Text(title ?? "详情页面",style: TextStyle(color: Colors.red),),
            new Padding(padding: new EdgeInsets.only(top:10),),
            new Text(title ?? "详情页面",style: TextStyle(color: Colors.red),)
          ],
        ),
        ),
      );
    }
}