import 'dart:ffi';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HqProviderPage extends StatefulWidget {
  const HqProviderPage({super.key});

  @override
  State<HqProviderPage> createState() => _HqProviderPageState();
}

class HqCounterNotifier with ChangeNotifier {
  int count = 3;
  void increment() {
    count += 1;
    //通知所有的消费者，值改变了
    notifyListeners();
  }
}

// ChangeNotifierProvider widget 可以向其子孙节点暴露一个 ChangeNotifier 实例。它属于 provider package。
class _HqProviderPageState extends State<HqProviderPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HqProvider')),
      // 提供者,只能通知到子widget,可用于子widget之间进行通信
      body: ChangeNotifierProvider(
          create: (context) {
            return HqCounterNotifier();
          },
          child: HqProviderBody()),
      floatingActionButton: FloatingActionButton(
        child: Text("Add"),
        onPressed: () {},
      ),
    );
  }
}

class HqProviderBody extends StatelessWidget {
  const HqProviderBody({super.key});

  @override
  Widget build(BuildContext context) {


    return Center(
        child: Column(
      children: [
        //消费者/观察者
        Consumer<HqCounterNotifier>(
          builder: (context, conterNotifer, child) {
            if (child != null) {
              return child;
            }
            return Text('${conterNotifer.count}');
          },
        ),

        ElevatedButton(
            onPressed: () {
              //获取提供者
              HqCounterNotifier counter = context.read<HqCounterNotifier>();
              //改变值，触发通知
              counter.increment();
            },
            child: Text('Add')),
        //子组件消费者
        _HqSubWidget(),


        
      ],
    ));
  }
}

class _HqSubWidget extends StatelessWidget {
  const _HqSubWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: //消费者/观察者
          Consumer<HqCounterNotifier>(
        builder: (context, conterNotifer, child) {
          return Text('SubWidget:${conterNotifer.count}');
        },
      ),
    );
  }
}

