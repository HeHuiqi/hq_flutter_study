import 'package:flutter/material.dart';
class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyAPP',
      theme: ThemeData(primarySwatch: Colors.red),
      home: SafeArea(
        child: MyScaffold(),
      ),
    );
  }
}

class MyAppBar extends StatelessWidget {
  final Widget title;
  const MyAppBar({required this.title,super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      
      height: 56.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(color: Colors.blue[500]),
      child: Row(
        children: [
          const IconButton(onPressed: null, icon: Icon(Icons.menu)),
          Expanded(child: title),
          const IconButton(onPressed: null, icon: Icon(Icons.search),tooltip: 'Search',)
        ],
      ),
    );
  }
}

class MyScaffold extends StatelessWidget {
  const MyScaffold({super.key});
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          MyAppBar(title:Text('Example',style: 
          Theme.of(context).primaryTextTheme.headline6)),
          const Expanded(child: Center(
            child: Text('Hello, world!'),
          ))
        ],
      ),
    );
  }
}
