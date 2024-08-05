import 'package:flutter/material.dart';

class HqTabsComponentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HqTabsComponentPageState();
}

class HqTabsComponentPageState extends State<HqTabsComponentPage> {
  int _selectedIndex = 0;

  final List<Widget> _children = [
    new PlaceholderWidget('Home'),
    new PlaceholderWidget('Love'),
    new PlaceholderWidget('Cart'),
    new PlaceholderWidget('Order'),
    new PlaceholderWidget('My'),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('HqTabBadge')),
      body: _children[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text('+'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            returnBottomItem(_selectedIndex, 0, Icons.home, "首页", 0),
            returnBottomItem(_selectedIndex, 1, Icons.favorite_border, "收藏", 0),
            returnBottomItem(
                _selectedIndex, 2, Icons.local_grocery_store, "购物车", 1),
            // SizedBox(width: 30, height: 20),
            returnBottomItem(_selectedIndex, 3, Icons.library_books, "订单", 0),
            returnBottomItem(_selectedIndex, 4, Icons.person, "我的", 0),
          ],
        ),
      ),
    );
  }

  returnBottomItem(
      int selectIndex, int index, IconData iconData, String title, int badge) {
    //未选中状态的样式
    TextStyle textStyle = TextStyle(fontSize: 12.0, color: Colors.grey);
    Color? iconColor = Colors.grey;
    double iconSize = 20;
    EdgeInsetsGeometry padding = EdgeInsets.only(top: 8.0);

    if (selectIndex == index) {
      //选中状态的文字样式
      textStyle =
          TextStyle(fontSize: 12.0, color: Theme.of(context).primaryColor);
      //选中状态的按钮样式
      iconColor = Theme.of(context).primaryColor;
    }
    Widget padItem = SizedBox();
    padItem = Padding(
        padding: padding,
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Icon(
                      iconData,
                      color: iconColor,
                      size: iconSize,
                    ),
                    Text(
                      title,
                      style: textStyle,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              child: badge > 0
                  ? Container(
                      width: badge <= 10 ? 13 : null,
                      height: 12,
                      child: Center(
                        child: Text(badge > 100 ? '99+' : badge.toString(),
                            style:
                                TextStyle(fontSize: 8.0, color: Colors.white)),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: new BorderRadius.all(
                          const Radius.circular(16.0),
                        ),
                      ),
                    )
                  : Text(""),
              right: 20.0,
              top: 0.0,
            ),
          ],
        ));
    Widget item = Expanded(
      flex: 1,
      child: new GestureDetector(
        onTap: () {
          if (index != _selectedIndex) {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
        child: SizedBox(
          height: 52,
          child: padItem,
        ),
      ),
    );
    return item;
  }
}

class PlaceholderWidget extends StatelessWidget {
  final String text;

  PlaceholderWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text(text),
    );
  }
}
