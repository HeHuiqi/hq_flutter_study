import 'package:flutter/material.dart';

class HqPainterSignPage extends StatelessWidget {
  const HqPainterSignPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('HqPainterSign'),
        ),
        body: _HqSignature());
  }
}

class _HqSignature extends StatefulWidget {
  const _HqSignature({super.key});

  @override
  State<_HqSignature> createState() => _HqSignatureState();
}

class _HqSignatureState extends State<_HqSignature> {
  List<Offset?> _points = <Offset?>[];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          RenderBox? referenceBox = context.findRenderObject() as RenderBox;
          Offset localPosition =
              referenceBox.globalToLocal(details.globalPosition);
          _points = List.from(_points)..add(localPosition);
        });
      },
      onPanEnd: (details) => _points.add(null),
      child: CustomPaint(
        painter: _HqSignaturePainter(_points),
        size: Size.infinite,
      ),
    );
  }
}
// 这是我们的画布
class _HqSignaturePainter extends CustomPainter {
  _HqSignaturePainter(this.points);

  final List<Offset?> points;

  //在这里绘制自己的想法
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_HqSignaturePainter oldDelegate) =>
      oldDelegate.points != points;
}
