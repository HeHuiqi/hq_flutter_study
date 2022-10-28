import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HqPaintDashBoard extends StatelessWidget {
  const HqPaintDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PaintDashBorad')),
      body: Container(
          color: Color.fromARGB(255, 207, 232, 207),
          child: Column(
            children: [
              DashBoard(),
              Divider(),
              CustomPaint(
                painter: HqDashBoardBgPainter(),
                size: Size(200, 200),
              )
            ],
          )),
    );
  }
}

class DashBoard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new DashBoardState();
  }
}

class DashBoardState extends State<DashBoard> {
  final platform = const MethodChannel('com.flutter.lgyw/sensor');
  bool _isGetPressure = false;
  int pressures = 0;
  final double wholeCirclesRadian = 6.283185307179586;

  ///虽然一个圆被分割为160份，但是只显示120份
  final int tableCount = 160;
  late Size dashBoardSize;
  late double tableSpace;
  late Picture _pictureBackGround;
  late Picture _pictureIndicator;

  @override
  void initState() {
    super.initState();
    dashBoardSize = new Size(300.0, 300.0);
    tableSpace = wholeCirclesRadian / tableCount;
    _pictureBackGround =
        DashBoardTablePainter(tableSpace, dashBoardSize).getBackGround();
    _pictureIndicator = IndicatorPainter(dashBoardSize).drawIndicator();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onPanDown: (DragDownDetails dragDownDetails) {
          _isGetPressure = true;
          boostSpeed();
        },
        onPanCancel: () {
          handleEndEvent();
        },
        onPanEnd: (DragEndDetails dragEndDetails) {
          handleEndEvent();
        },
        child: new CustomPaint(
          size: dashBoardSize,
          painter: DashBoardBgPainter(),
          foregroundPainter: new DashBoardIndicatorPainter(
              pressures, tableSpace, _pictureBackGround, _pictureIndicator),
          // child: Text('Paint Child'),
        ),
      ),
    );
  }

  void boostSpeed() async {
    while (_isGetPressure) {
      if (pressures < 120) {
        setState(() {
          pressures++;
        });
      }
      await Future.delayed(new Duration(milliseconds: 30));
    }
  }

  void handleEndEvent() {
    _isGetPressure = false;
    bringDownSpeed();
  }

  void bringDownSpeed() async {
    while (!_isGetPressure) {
      setState(() {
        pressures--;
      });

      if (pressures <= 0) {
        break;
      }
      await Future.delayed(new Duration(milliseconds: 30));
    }
  }
}

class HqDashBoardBgPainter extends CustomPainter {
  Paint p = Paint();

  void changePaintColors(Paint paint, int value) {
    if (value <= 4) {
      paint.color = Colors.green;
    } else if (value < 8) {
      paint.color = Colors.blue;
    } else {
      paint.color = Colors.red;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    p.color = Color.fromARGB(255, 172, 213, 234);
    p.style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), p);
    double halfWidth = size.width / 2.0;
    double halfHeight = size.height / 2.0;
    //将原点(0,0)，平移到(halfWidth,halfHeight)，即平移到中心
    canvas.translate(halfWidth, halfHeight);
    p.color = Colors.purple;

    double space = 2 * pi / 12;
    p.strokeWidth = 5;
    for (var i = 0; i < 12; i++) {
      double endY = -halfHeight;
      double startY = 0.0; 
      startY = endY;     
      changePaintColors(p, i == 0 ? 12:i);
      // drawLine(startP,endP,paint),其实执行了两个步骤
      // 1.从原点先移动到startP位置
      // 2.然后再从startP位置开始绘制到endP的位置
      canvas.drawLine(Offset(0, startY), Offset(0, endY + 15), p);

      TextPainter textPainter = new TextPainter();
      textPainter.textDirection = TextDirection.ltr;
      String text = i == 0 ? '12' : '$i';
      textPainter.text = new TextSpan(
          text: text,
          style: new TextStyle(
            color: p.color,
            fontSize: 15.5,
          ));
      textPainter.layout();
      double textStarPositionX = -textPainter.size.width / 2;
      double textStarPositionY = endY + 20;
      textPainter.paint(
          canvas, new Offset(textStarPositionX, textStarPositionY));
      //旋转以中心点旋转，默认(0,0),因为在此之前我们translate()到中心，所以此刻是以中心旋转
      canvas.rotate(space);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class DashBoardBgPainter extends CustomPainter {
  Paint p = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    p.color = Color.fromARGB(255, 172, 213, 234);
    p.style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class DashBoardIndicatorPainter extends CustomPainter {
  final int speeds;
  double tableSpace;
  final Picture pictureBackGround;
  final Picture pictureIndicator;

  DashBoardIndicatorPainter(this.speeds, this.tableSpace,
      this.pictureBackGround, this.pictureIndicator);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPicture(pictureBackGround);
    drawIndicator(canvas, size);
    print('speeds:$speeds');
    String text;
    // if (speeds < 100) {
    //   text = (speeds * 2).toString() + "KM/H";
    // } else {
    //   int s = speeds - 100;
    //   text = (100 * 2 + s * 2).toString() + "KM/H";
    // }
          text = (speeds * 2).toString() + "KM/H";

    drawSpeendOnDashBoard(text, canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  ///画实时得速度值到面板上
  void drawSpeendOnDashBoard(String text, Canvas canvas, Size size) {
    double halfHeight = size.height / 2;
    double halfWidth = size.width / 2;
    canvas.save();
    canvas.translate(halfWidth, halfHeight);

    TextPainter textPainter = new TextPainter();
    textPainter.textDirection = TextDirection.ltr;
    textPainter.text = new TextSpan(
        text: text,
        style: new TextStyle(
            color: Colors.deepOrangeAccent,
            fontSize: 25.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold));
    textPainter.layout();
    double textStarPositionX = -textPainter.size.width / 2;
    double textStarPositionY = 73;
    textPainter.paint(canvas, new Offset(textStarPositionX, textStarPositionY));

    canvas.restore();
  }

  ///画速度指针
  void drawIndicator(Canvas canvas, Size size) {
    double halfHeight = size.height / 2;
    double halfWidth = size.width / 2;

    canvas.save();
    canvas.translate(halfWidth, halfHeight);
    //因为只显示了120份，左边60份，右边60份，默认在中间
    //显示时是在左边0刻度，所以初始值应为 （0 - 60）
    canvas.rotate((-60 + speeds) * tableSpace);
    // canvas.rotate((speeds) * tableSpace);

    canvas.translate(-halfWidth, -halfHeight);

    canvas.drawPicture(pictureIndicator);

    canvas.restore();
  }
}

class IndicatorPainter {
  final PictureRecorder _recorder = PictureRecorder();
  final Size size;

  IndicatorPainter(this.size);

  ///画速度指针
  Picture drawIndicator() {
    Canvas canvas = Canvas(_recorder);
    canvas.clipRect(new Rect.fromLTWH(0.0, 0.0, size.width, size.height));

    double halfHeight = size.height / 2;
    double halfWidth = size.width / 2;
    canvas.translate(halfWidth, halfHeight);

    Path path = new Path();
    path.moveTo(-2.5, 20);
    path.lineTo(2.5, 20);
    path.lineTo(6.0, -30);
    path.lineTo(0.5, -halfHeight + 8);
    path.lineTo(-0.5, -halfHeight + 8);
    path.lineTo(-6.0, -30);
    path.close();
    canvas.save();


    Paint paint = new Paint();
    // paint.color = Colors.red;
    paint.color = Colors.purple;
    paint.style = PaintingStyle.fill;
    // paint.style = PaintingStyle.stroke;

    canvas.drawPath(path, paint);

    paint.color = Colors.black;
    canvas.drawCircle(new Offset(0.0, 0.0), 6, paint);

    canvas.restore();
    return _recorder.endRecording();
  }
}

class DashBoardTablePainter {
  final double tableSpace;
  var speedTexts = [
    "0",
    "20",
    "40",
    "60",
    "80",
    "100",
    "120",
    "140",
    "160",
    "180",
    "200",
    "220",
    "240"
  ];
  final Size size;
  final PictureRecorder _recorder = PictureRecorder();

  DashBoardTablePainter(this.tableSpace, this.size);

  Picture getBackGround() {
    Canvas canvas = Canvas(_recorder);
    canvas.clipRect(new Rect.fromLTWH(0.0, 0.0, size.width, size.height));
    drawTable(canvas, size);
    return _recorder.endRecording();
  }

  ///画仪表盘的表格
  void drawTable(Canvas canvas, Size size) {
    canvas.save();
    double halfWidth = size.width / 2;
    double halfHeight = size.height / 2;
    //将原点从左上角平移到中心
    canvas.translate(halfWidth, halfHeight);
    // canvas.translate(halfWidth, 0);
    // canvas.translate(3, halfHeight);

    Paint paintMain = new Paint();
    paintMain.color = Colors.blue;
    paintMain.strokeWidth = 2.5;
    paintMain.style = PaintingStyle.fill;

    Paint paintOther = new Paint();
    paintOther.color = Colors.blue;
    paintOther.strokeWidth = 1;
    paintOther.style = PaintingStyle.fill;

    drawLongLine(canvas, paintMain, halfHeight, speedTexts[6]);

    //画右半部分
    canvas.save();
    for (int i = 61; i <= 120; i++) {
      canvas.rotate(tableSpace);
      if (i % 10 == 0) {
        int a = (i / 10).ceil();
        changePaintColors(paintMain, i);
        drawLongLine(canvas, paintMain, halfHeight, speedTexts[a]);
      } else if (i % 5 == 0) {
        changePaintColors(paintMain, i);
        drawMiddleLine(canvas, paintMain, halfHeight);
      } else {
        changePaintColors(paintOther, i);
        drawSmallLine(canvas, paintOther, halfHeight);
      }
    }
    canvas.restore();

    //画左半部分
    canvas.save();
    for (int i = 59; i >= 0; i--) {
      canvas.rotate(-tableSpace);
      if (i % 10 == 0) {
        int a = (i / 10).ceil();
        changePaintColors(paintMain, i);
        drawLongLine(canvas, paintMain, halfHeight, speedTexts[a]);
      } else if (i % 5 == 0) {
        changePaintColors(paintMain, i);
        drawMiddleLine(canvas, paintMain, halfHeight);
      } else {
        changePaintColors(paintOther, i);
        drawSmallLine(canvas, paintOther, halfHeight);
      }
    }
    canvas.restore();

    canvas.restore();
  }

  void changePaintColors(Paint paint, int value) {
    if (value <= 20) {
      paint.color = Colors.green;
    } else if (value < 80) {
      paint.color = Colors.blue;
    } else {
      paint.color = Colors.red;
    }
  }

  ///画仪表盘上的长线
  void drawLongLine(
      Canvas canvas, Paint paintMain, double halfHeight, String text) {
    canvas.drawLine(new Offset(0.0, -halfHeight),
        new Offset(0.0, -halfHeight + 15), paintMain);
    // canvas.drawLine(new Offset(0.0, halfHeight), new Offset(0.0,  halfHeight+20), paintMain);

    TextPainter textPainter = new TextPainter();
    textPainter.textDirection = TextDirection.ltr;
    textPainter.text = new TextSpan(
        text: text,
        style: new TextStyle(
          color: paintMain.color,
          fontSize: 15.5,
        ));
    textPainter.layout();
    double textStarPositionX = -textPainter.size.width / 2;
    double textStarPositionY = -halfHeight + 19;
    textPainter.paint(canvas, new Offset(textStarPositionX, textStarPositionY));
  }

  //画5倍数的短线
  void drawMiddleLine(Canvas canvas, Paint paintMain, double halfHeight) {
    canvas.drawLine(new Offset(0.0, -halfHeight),
        new Offset(0.0, -halfHeight + 10), paintMain);
  }

  ///画短线
  void drawSmallLine(Canvas canvas, Paint paintOther, double halfHeight) {
    canvas.drawLine(new Offset(0.0, -halfHeight),
        new Offset(0.0, -halfHeight + 7), paintOther);
  }
}
