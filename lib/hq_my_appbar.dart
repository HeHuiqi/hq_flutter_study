import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget{

  MyAppBar({this.title});
  final Widget title;
  @override
    Widget build(BuildContext context) {
      
      return new Container(
        height: 64.0,
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        decoration: new BoxDecoration(color: Colors.blue[500]),
        child: new Row(
          children: <Widget>[
            new IconButton(
              icon: new Icon(Icons.menu),
              tooltip: 'Menu',
              color: Colors.white,
              onPressed: (){
                 final menu = '我是左侧按钮';
                 print('菜单== $menu');
              },
            ),
            new Expanded(
              child: title,
            ),
            new IconButton(
              icon: new Icon(Icons.search),
              tooltip: 'Search',
              color: Colors.white,
              onPressed: (){
                final search = '我是右侧按钮';
                print('搜索== $search');
              },
            )
          ],
        ),
      );
    }
}

class MyScaffold extends StatelessWidget {

      Future<void> _neverSatisfied(BuildContext context) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
        return SimpleDialog(
        title: const Text('Select assignment'),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () { Navigator.pop(context); },
            child: const Text('Treasury department'),
          ),
          SimpleDialogOption(
            onPressed: () { Navigator.pop(context); },
            child: const Text('State department'),
          ),
        ],
      );
        },
      );
    }
  @override
    Widget build(BuildContext context) {
      return new Material(
        child: new Column(
          children: <Widget>[
            new MyAppBar(
              title: new Text('MyAppBar',style: Theme.of(context).primaryTextTheme.title),
              
            ),
            new Expanded(
              child: new Center(
                child: new Text('Hello world!'),
              ),
            ),
             new RaisedButton(
                
                textColor: Colors.white,
                onPressed: (){
                    // print("123");
                    // Widget dl = Dialog(child: new Text('我好吗'),);
                    // Navigator.of(context).push(dl);
                    this._neverSatisfied(context);
                },
                color: Colors.blue,
                disabledColor: Colors.grey,
                textTheme: ButtonTextTheme.normal,
                child: new Text('\n我是一个Button\n我会随着标题的变化而变化\n',textAlign: TextAlign.center),
            ),
             new Expanded(
              child: new Center(
                child: new Text('Hello world2!'),
              ),
            ),
           
          ],
        ),
      );
    }
}

class HqAppBar extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      return new MaterialApp(
        title: 'My App',
        theme: ThemeData(
          primaryColor: Colors.blue
        ),
        home: new MyScaffold(),
  );
    }
}