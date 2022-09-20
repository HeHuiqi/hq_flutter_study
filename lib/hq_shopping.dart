import 'package:flutter/material.dart';

class HqProduct {
  final String name;
  const HqProduct({required this.name});
}

typedef HqCartChangedCallback = Function(HqProduct product, bool inCart);

//当用户点击列表中的一项，widget 不会直接改变 inCart 的值，
//而是通过调用从父 widget 接收到的 onCartChanged 函数。
//这种方式可以在组件的生命周期中存储状态更长久，从而使状态持久化。
//甚至，widget 传给 runApp() 的状态可以持久到整个应用的生命周期
//定义购物车商品Item组件
class HqShoppingListItem extends StatelessWidget {
  const HqShoppingListItem(
      {required this.product,
      required this.inCart,
      required this.onCartChanged,
      super.key});
  final HqProduct product;
  final bool inCart;
  final HqCartChangedCallback onCartChanged;

  //根据是否在购物车中来显示不同的颜色表示
  Color _getColor(BuildContext context) {
    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!inCart) return null;
    return const TextStyle(
        color: Colors.black54,
        //加上删除线样式
        decoration: TextDecoration.lineThrough);
  }

  @override
  Widget build(BuildContext context) {
    // 这将会占满屏幕一行，相当于UITableViewCell
    return Column(children: [
      ListTile(
        onTap: () {
          onCartChanged(product, inCart);
        },
        //设置左边的组件
        leading: CircleAvatar(
          backgroundColor: _getColor(context),
          child: Text(product.name[0]),
        ),
        //设置标题
        title: Text(
          product.name,
          style: _getTextStyle(context),
        ),
      ),
      const Divider(
        indent: 15,
        // endIndent: 15,
        color: Colors.cyan,
        height: 1,
      ),
    ]);
  }
}

class HqShoppingList extends StatefulWidget {
  const HqShoppingList({required this.products, super.key});
  final List<HqProduct> products;

  @override
  State<HqShoppingList> createState() => _HqShoppingListState();
}

class _HqShoppingListState extends State<HqShoppingList> {
  final _shoppingCart = <HqProduct>{};
  void _handleCartChanged(HqProduct product, bool inCart) {
    setState(() {
      if (!inCart) {
        _shoppingCart.add(product);
      } else {
        _shoppingCart.remove(product);
      }
      print(_shoppingCart);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      //通过State的widget属性来访问其绑定的属性
      children: widget.products.map((product) {
        return HqShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged);
      }).toList(),
    );
  }
}
