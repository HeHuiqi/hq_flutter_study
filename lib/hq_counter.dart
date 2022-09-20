import 'package:flutter/material.dart';
/*
 * 创建两个新的无状态 widget 的方式，它清楚地分离了 显示 计数器（CounterDisplay）和 改变 计数器（CounterIncrementor）。
 * 尽管最终结果与前面的示例相同，但是责任的分离将更大的复杂性封装在各个 widget 中，保证了父级的简单性。
 */
class HqCounterDisplay extends StatelessWidget {
  const HqCounterDisplay({required this.count ,super.key});
  final int count;

  @override
  Widget build(BuildContext context) {
    return Text('Count: $count');
  }
}
class HqCounterIncrementor extends StatelessWidget {
  const HqCounterIncrementor({required this.onPressed,super.key});
  //添加一个回调属性用于从外部传递
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('Increment'),
    );
  }
}
class HqCounter extends StatefulWidget {
  const HqCounter({super.key});

  @override
  State<HqCounter> createState() => _HqCounterState();
}

class _HqCounterState extends State<HqCounter> {

  int _counter = 0;
  void _increment(){
    setState(() {
      _counter ++;
      print('count:$_counter');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        HqCounterIncrementor(onPressed: _increment),
        const SizedBox(width: 16,),
        HqCounterDisplay(count: _counter),
      ],
    );
  }
}