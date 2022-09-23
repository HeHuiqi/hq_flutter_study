import 'package:flutter/material.dart';

class HqAnimationPage extends StatefulWidget {
  const HqAnimationPage({super.key});

  @override
  State<HqAnimationPage> createState() => _HqAnimationPageState();
}

class _HqAnimationPageState extends State<HqAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  double padding = 20;
  double height = 300;
  late Animation<double>  a1;
  late Animation<double>  a2;

  @override
  void initState() {
    animationController = AnimationController(duration: const Duration(milliseconds: 800),vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: padding),
              color: Colors.blue,
              height: height,
              width: 100,
            ),
            ElevatedButton(
                onPressed: (() {
                 a1 =   Tween<double>(begin: height, end: height - 10)
                      .animate(animationController)
                    ..addListener(() {
                      setState(() {
                        height = a1.value;
                      });
                    });
                  a2 =   Tween<double>(begin: padding, end: padding + 20)
                      .animate(animationController)
                    ..addListener(() {
                      setState(() {
                        padding = a2.value;
                      });
                    });
                  animationController.reset();
                  animationController.forward();
                }),
                child: Text('动'))
          ],
        ),
      ),
    );
  }
}
