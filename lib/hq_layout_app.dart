import 'package:flutter/material.dart';

import 'hq_shopping.dart';
import 'hq_gridview_page.dart';

class HqLayoutApp extends StatelessWidget {
  const HqLayoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: HqLayoutHome(),
    );
  }
}

class HqLayoutHome extends StatefulWidget {
  const HqLayoutHome({super.key});

  @override
  State<HqLayoutHome> createState() => _HqLayoutHomeState();
}

class _HqLayoutHomeState extends State<HqLayoutHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('HqLayout'),
        ),
        body: HqBody(),
        bottomNavigationBar: HqBottomTabBar());
  }
}

class HqBody extends StatelessWidget {
  const HqBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // Flexible 会占用剩余空间
          Flexible(
              child: HqShoppingList(products: [
            HqProduct(name: '苹果'),
            HqProduct(name: '香蕉'),
            HqProduct(name: '葡萄'),
            HqProduct(name: '橘子'),
            HqProduct(name: '西瓜'),
            HqProduct(name: '芒果'),
          ])),
          Container(
            height: 100,
            child:Image.asset('images/pic1.jpg') ,
          ),
          Container(height: 100,child: Image.asset('images/pic3.jpg'),),
          Container(
            width: 100,
            height: 100,
            //装饰组件，可以设置背景色、边框、圆角等
            decoration: BoxDecoration(
                color: Colors.cyan,
                border: Border.all(width: 1.0, color: Colors.purple),
                shape: BoxShape.circle),
            child: Align(
              child: IconButton(
                icon: Icon(Icons.arrow_forward,color: Colors.white,),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const HqGridViewPage(),
                    ),
                  );
                },
              ),
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }
}

class HqBottomTabBar extends StatelessWidget {
  const HqBottomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            child: Container(
          height: 60,
          color: Colors.orange,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                color: Colors.red,
                padding: EdgeInsets.all(8.0),
                child: Text('tab1'),
              ),
              Container(
                color: Colors.green,
                padding: EdgeInsets.all(8.0),
                child: Text('tab2'),
              ),
              Container(
                child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const HqGridViewPage(),
                        ),
                      );
                    },
                    icon: Icon(Icons.home),
                    label: Text('home')),
              ),
            ],
          ),
        ))
      ],
    );
  }
}
