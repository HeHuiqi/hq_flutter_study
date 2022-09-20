import 'package:flutter/material.dart';

void main() => runApp(const HqAnimatedWidgetApp());

class HqAnimatedWidgetLogo extends AnimatedWidget {
  const HqAnimatedWidgetLogo({super.key, required Animation<double> animation})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: animation.value,
      width: animation.value,
      child: const FlutterLogo(),
    );
  }
}
// #enddocregion HqAnimatedWidgetLogo

class HqAnimatedWidgetApp extends StatefulWidget {
  const HqAnimatedWidgetApp({super.key});

  @override
  State<HqAnimatedWidgetApp> createState() => _HqAnimatedWidgetAppState();
}

class _HqAnimatedWidgetAppState extends State<HqAnimatedWidgetApp>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  bool isBig = false;
  bool isAuto = false; //是否开始后自动放大缩小
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    animation = Tween<double>(begin: 50, end: 200).animate(controller);
    animation.addStatusListener((status) {
      print('status:$status');

      if (isAuto) {
        if (status == AnimationStatus.dismissed) {
          controller.forward();
          setState(() {
            isBig = !isBig;
          });
        } else if (status == AnimationStatus.completed) {
          controller.reverse();
          setState(() {
            isBig = !isBig;
          });
        }
      } else {
        if (status == AnimationStatus.completed ||
            status == AnimationStatus.dismissed) {
          //动画完成时调用setState()来触发重绘，来改变btn的标题
          setState(() {
            print('complete: ${animation.value}');
            isBig = !isBig;
          });
        }
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HqAnimatedWidget')),
      body: Center(
        child: Column(
          children: [
            // HqAnimatedWidgetLogo(animation: animation),
            GrowTransition(
              child: LogoWidget(),
              animation: animation,
            ),
            ElevatedButton(
                onPressed: (() {
                  print('animation.status:${animation.status}');

                  if (isAuto) {
                    controller.forward();
                  } else {
                    if (animation.status == AnimationStatus.completed) {
                      //反转动画
                      controller.reverse();
                    } else {
                      //触发动画
                      controller.forward();
                    }
                  }
                }),
                child: Text(isBig ? '缩小' : '放大'))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}


//使用 AnimatedBuilder 优化动画,将wiget和动画分离
class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  // Leave out the height and width so it fills the animating parent
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: const FlutterLogo(),
    );
  }
}
// #enddocregion LogoWidget

// #docregion GrowTransition
class GrowTransition extends StatelessWidget {
  const GrowTransition(
      {required this.child, required this.animation, super.key});

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return SizedBox(
            height: animation.value,
            width: animation.value,
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}
