import 'package:flutter/material.dart';

class HqCustomRouteAnimationPage extends StatelessWidget {
  const HqCustomRouteAnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HqCustomRoute'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(_createRoute());
          },
          child: const Text('Go!'),
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const Page2(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //从底部
      const begin = Offset(0.0, 1.0);
      //到顶部
      const end = Offset(0.0,0.0);

      const curve = Curves.ease;

      var slideTween =
          Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      //顺时针旋转
      var rotationTween = Tween(begin: 0.0, end: 1.0);

      return SlideTransition(
        position: animation.drive(slideTween),
        child: child,
      );

      // return RotationTransition(
      //   turns: animation.drive(rotationTween),
      //   child: child,
      // );

      // return FadeTransition(
      //   opacity: animation.drive(rotationTween),
      //   child: child,
      // );
    },
  );
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HqCustomRoutePage2'),
      ),
      body: const Center(
        child: Text('Page 2'),
      ),
    );
  }
}
