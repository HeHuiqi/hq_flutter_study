import 'package:flutter/material.dart';
import 'hq_custom_btn.dart';
import 'hq_counter.dart';
import 'hq_shopping.dart';

class HqMaterialApp extends StatelessWidget {
  const HqMaterialApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Turial',
      home: HqStartPage(),
    );
  }
}

class HqStartPage extends StatelessWidget {
  const HqStartPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const IconButton(
            onPressed: null, tooltip: 'Nav menu', icon: Icon(Icons.menu)),
        title: const Text('Example Title'),
        actions: [
          IconButton(
              onPressed: null, icon: Icon(Icons.search), tooltip: 'Search'),
        ],
      ),
      body: Center(
          child: Column(children: <Widget>[
        Text('123'),
        HqCustomButton(),
        HqCounter(),
        HqShoppingListItem(
          product: const HqProduct(name: '苹果'),
          inCart: true,
          onCartChanged: (product, inCart) {},
        ),
        Row(
          // 水平对齐
          mainAxisAlignment: MainAxisAlignment.start,
          // 垂直对齐
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.red,
              height: 300,
              width: 200,
              child: HqShoppingList(products: [
                HqProduct(name: '苹果'),
                HqProduct(name: '香蕉'),
                HqProduct(name: '葡萄'),
                HqProduct(name: '橘子'),
              ]),
            ),
            Container(
              height: 50,
              color: Colors.blue,
              child: Text('test'),
            ),
          ],
        ),
        Flexible(child: 
        Container(
          height: 150,
            child: ListView(
              // 设置水平滚动
              scrollDirection: Axis.horizontal,
          children: [
            Image.asset(
              'images/pic1.jpg',
              // height: 100,
            ),
            SizedBox(width: 10,),
            Image.asset(
              'images/pic2.jpg',
              // height: 100,
            ),
            SizedBox(width: 10,),
            Image.asset(
              'images/pic3.jpg',
              // height: 100,
            ),
            SizedBox(width: 10,),
             Image.asset(
              'images/pic1.jpg',
              height: 100,
            ),
            SizedBox(width: 10,),
            Image.asset(
              'images/pic2.jpg',
              // height: 100,
            ),
            SizedBox(width: 10,),
            Image.asset(
              'images/pic3.jpg',
              // height: 100,
            ),
          ],
        ))),
      ])),
      floatingActionButton:  FloatingActionButton(
        onPressed:() {
          print('floatingActionButton click');
        },
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }
}
