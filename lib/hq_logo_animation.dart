import 'dart:ui';

import 'package:flutter/material.dart';

class HqLogoMoveAnimationPage extends StatefulWidget {
  const HqLogoMoveAnimationPage({super.key});

  @override
  State<HqLogoMoveAnimationPage> createState() =>
      _HqLogoMoveAnimationPageState();
}

class _HqLogoMoveAnimationPageState extends State<HqLogoMoveAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> sizeAnimation;
  late AnimationController controller1;
  late Animation<Color?> colorAnimation;
  double initLeft = 0;
  bool isBack = false;
  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    colorAnimation =
        ColorTween(begin: Colors.yellow, end: Colors.purple).animate(controller)
          ..addListener(() {
            //这里必须调用来触发重会
            setState(() {});
          });

    sizeAnimation =
        Tween<double>(begin: initLeft, end: initLeft + 60).animate(controller)
          ..addListener(() {
            setState(() {});
          });
    sizeAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Size size = window.physicalSize;
        if (sizeAnimation.value * 2 + 50 >= size.width / 2.0) {
          isBack = true;
        }
        if (sizeAnimation.value <= 0) {
          isBack = false;
        }
        initLeft = sizeAnimation.value;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Animation')),
        body: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                color: colorAnimation.value,
                margin: EdgeInsets.fromLTRB(sizeAnimation.value, 0, 0, 0),
                height: sizeAnimation.value + 50,
                width: sizeAnimation.value + 50,
                child: const FlutterLogo(),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (sizeAnimation.value > 0) {
                    print('animation1 initLeft:$initLeft');
                    print('1:animaton.value:${sizeAnimation.value}');

                    double space = isBack ? -60 : 60;
                    double end = initLeft + space;
                    print('end:$end');
                    sizeAnimation = Tween<double>(begin: initLeft, end: end)
                        .animate(controller)
                      ..addListener(() {
                        setState(() {});
                      });
                    print('3:animaton.value:${sizeAnimation.value}');
                  } else {
                    sizeAnimation =
                        Tween<double>(begin: initLeft, end: initLeft + 60)
                            .animate(controller)
                          ..addListener(() {
                            setState(() {});
                          });
                  }
                  if (colorAnimation.value == Colors.purple) {
                    colorAnimation =
                        ColorTween(begin: Colors.purple, end: Colors.yellow)
                            .animate(controller)
                          ..addListener(() {
                            setState(() {});
                          });
                  } else {
                    colorAnimation =
                        ColorTween(begin: Colors.yellow, end: Colors.purple)
                            .animate(controller)
                          ..addListener(() {
                            setState(() {});
                          });
                  }
                  controller.reset();

                  controller.forward();
                },
                child: Text('点击开始动画')),
          ],
        ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
