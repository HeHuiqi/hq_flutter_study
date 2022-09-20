import 'package:flutter/material.dart';
import 'default_app.dart';
import 'my_material_app.dart';
import 'material_app.dart';

import 'hq_study_list.dart';
class Hello extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: Text(
        'Hello, world!',
        textDirection: TextDirection.ltr,
      ),
    );
  }
}


void main() {
  //开始调试绘制线
  // debugPaintSizeEnabled = true;
  // runApp(MyApp());
  // runApp(Hello());
  // runApp(MyMaterialApp());
  runApp(HqSutdyApp());
}
