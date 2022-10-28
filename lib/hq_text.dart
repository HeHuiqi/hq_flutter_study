import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';



class HqTextPage extends StatefulWidget {
  const HqTextPage({super.key});

  @override
  State<HqTextPage> createState() => _HqTextPageState();
}

class _HqTextPageState extends State<HqTextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HqText'),
      ),
      body: ListView(
        children: [
          _HqRichText(),
          _HqBox(
            bgColor: Colors.red,
          ),
          _HqBox(
            bgColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}


class _HqRichText extends StatelessWidget {
  const _HqRichText({super.key});

  void showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('你点击了服务协议!'),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Action',
          onPressed: () {
            // Code to execute.
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();
     _tapGestureRecognizer.onTap = () {
      print('tapText');
      // Fluttertoast.showToast(msg: '你点击了服务协议!', gravity: ToastGravity.CENTER);
      showSnackBar(context);
    };
    return Container(
      color: Color.fromARGB(255, 174, 231, 82),
      height: 40,
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          text: '请仔细阅读 ',
          style: TextStyle(color: Colors.grey),
          children: <TextSpan>[
            TextSpan(
              text: '《服务协议》',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              //增加手势
              recognizer: _tapGestureRecognizer,
            ),
            TextSpan(text: ' 的内容!', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class _HqBox extends StatefulWidget {
  final Color? bgColor;
  _HqBox({super.key, this.bgColor});
  @override
  State<_HqBox> createState() => __HqBoxState();
}

class __HqBoxState extends State<_HqBox> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ElevatedButton(
          onPressed: () {
            setState(() {
              isOpen = !isOpen;
            });
          },
          child: Text(isOpen ? 'Colose' : 'Open')),
      Container(
        //设置改容器的最小大小
        // constraints: BoxConstraints(minHeight: 20,minWidth: 100),
        color: widget.bgColor,
        // width: 100,
        // height: 20,
        child: Text(
          'BoxConstraints作为Container的属性，设置Container的宽高，以约束子widget的大小,BoxConstraints作为Container的属性，设置Container的宽高，以约束子widget的大小',
          //设置文本截断方式
          overflow: TextOverflow.ellipsis,
          maxLines: isOpen ? 1 << 31 : 2,
        ),
      )
    ]);
  }
}
