import 'package:flutter/material.dart';

class HqTempPage extends StatelessWidget {
  final String? data;
  HqTempPage({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HqTempPage')),
      body: Center(
        child: Text('缓冲页面：${data}'),
      ),
    );
  }
}
