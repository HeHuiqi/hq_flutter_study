import 'package:flutter/material.dart';
class HqCustomButton extends StatelessWidget{
  const HqCustomButton({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('HqCustomButton was tapped!');
      },
      child: Container(
        height: 50.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.lightGreen[500]
        ),
        child: const Center(
          child: Text('MyCustomButton'),
        ),
      ),
    );
  }
}