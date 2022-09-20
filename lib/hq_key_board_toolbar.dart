import 'package:flutter/material.dart';
import 'dart:math' as math;

class HqFocusNodeState {
  FocusNode? currentNode;
  FocusNode? nextNode;
  int currentIndex = 0;
  bool isShowkeyboard = false;
  HqFocusNodeState(
      {this.currentNode,
      this.nextNode,
      required this.isShowkeyboard,
      required this.currentIndex});
  static HqFocusNodeState getFocusNodeState(List<FocusNode> nodes) {
    FocusNode? currentNode;
    FocusNode? nextNode;
    bool show = false;
    int currentIndex = 0;
    for (var focusNode in nodes) {
      if (focusNode.hasFocus) {
        show = true;
        break;
      }
      currentIndex++;
    }
    print('currentIndex:$currentIndex');
    if (show && nodes.length > 1) {
      if (currentIndex == 0) {
        currentNode = nodes[currentIndex];
        nextNode = nodes[currentIndex + 1];
      } else if (currentIndex >= nodes.length - 1) {
        currentNode = nodes[currentIndex - 1];
        nextNode = nodes[currentIndex];
      } else {
        currentNode = nodes[currentIndex - 1];
        nextNode = nodes[currentIndex + 1];
      }
    }
    return HqFocusNodeState(
        currentNode: currentNode,
        nextNode: nextNode,
        isShowkeyboard: show,
        currentIndex: currentIndex);
  }
}

class HqLoginToolBarPage extends StatefulWidget {
  const HqLoginToolBarPage({super.key});

  @override
  State<HqLoginToolBarPage> createState() => _HqLoginToolBarPageState();
}

class _HqLoginToolBarPageState extends State<HqLoginToolBarPage> {
  bool keyboardIsShow = false;
  List<FocusNode> focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode()
  ];
  FocusNode? currentFocusNode;
  FocusNode? nextFocusNode;

  void focusNodeListener() {
    HqFocusNodeState state = HqFocusNodeState.getFocusNodeState(focusNodes);
    keyboardIsShow = state.isShowkeyboard;
    currentFocusNode = state.currentNode;
    nextFocusNode = state.nextNode;
    //触发渲染
    setState(() {});
  }

  @override
  void initState() {
    //为每个焦点添加监听
    for (var focusNode in focusNodes) {
      focusNode.addListener(focusNodeListener);
    }
    currentFocusNode = focusNodes[0];
    nextFocusNode = focusNodes[0];
    super.initState();
  }

  @override
  void dispose() {
    //要清楚每个焦点
    for (var focusNode in focusNodes) {
      focusNode.removeListener(focusNodeListener);
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('HqLoginToolBar'),
        ),
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              right: 0,
              child: ListView(
                children: [
                  HqInputView(
                    hintText: '输入用户名',
                    focusNode: focusNodes[0],
                    autofocus: true,
                    padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
                  ),
                  HqInputView(hintText: '输入密码', focusNode: focusNodes[1]),
                  HqInputView(hintText: '输入激活码', focusNode: focusNodes[2]),
                  HqInputView(hintText: '输入邀请码', focusNode: focusNodes[3]),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                    child: ElevatedButton(
                      child: Text('登录'),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              // top: 0,
              // left: 0,
              // bottom: 0,
              // right: 0,
              child: HqKeyBoardToolBar(
                keyboardIsShow: keyboardIsShow,
                preFocusNode: currentFocusNode,
                nextFocusNode: nextFocusNode,
              ),
              // child: Column(
              //   children: <Widget>[
              //     //这里是为了占据剩余空间，由此将下面的组件挤到最底部
              //     Flexible(child: Container()),
              //     Divider(height: 1.0,color: Color.fromARGB(255, 27, 28, 28),),
              //     HqKeyBoardToolBar(
              //       keyboardIsShow: keyboardIsShow,
              //       preFocusNode: currentFocusNode,
              //       nextFocusNode: nextFocusNode,
              //     ),
              //   ],
              // ),
            ),
          ],
        ));
  }
}

class HqInputView extends StatelessWidget {
  final String hintText;
  final FocusNode focusNode;
  final bool autofocus;
  final EdgeInsetsGeometry? padding;
  const HqInputView(
      {required this.hintText,
      required this.focusNode,
      this.autofocus = false,
      this.padding = const EdgeInsets.symmetric(horizontal: 20),
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: TextField(
        autofocus: autofocus,
        focusNode: focusNode,
        decoration: InputDecoration(hintText: hintText),
      ),
    );
  }
}

class HqKeyBoardToolBar extends StatelessWidget {
  final bool keyboardIsShow;
  final FocusNode? preFocusNode;
  final FocusNode? nextFocusNode;

  const HqKeyBoardToolBar(
      {required this.keyboardIsShow,
      this.preFocusNode,
      this.nextFocusNode,
      super.key});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      //这里是为了占据剩余空间，由此将下面的组件挤到最底部
      Flexible(child: Container()),
      Divider(
        height: 1.0,
      ),
      Container(
          color: Colors.white,
          height: keyboardIsShow ? 40 : 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (preFocusNode != null && nextFocusNode != null)
                  ? Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        HqFocusBtn(
                          focusNode: preFocusNode!,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        HqFocusBtn(
                          focusNode: nextFocusNode!,
                          isNext: true,
                        ),
                      ],
                    )
                  : Container(),
              Container(
                child: TextButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Text(
                    '完成',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ))
    ]);
  }
}

class HqFocusBtn extends StatelessWidget {
  final FocusNode focusNode;
  final bool isNext;
  const HqFocusBtn({required this.focusNode, this.isNext = false, super.key});

  @override
  Widget build(BuildContext context) {
    Widget btn = Transform(
        transform: Matrix4.identity()..rotateZ(isNext ? 0 : math.pi), // 旋转的角度
        origin: Offset(12, 12),
        child: Icon(
          Icons.arrow_forward_ios_sharp,
          color: focusNode.hasFocus ? Colors.grey : Colors.blue,
          size: 24.0,
        ));
    return InkWell(
      child: btn,
      onTap: () {
        focusNode.requestFocus();
      },
    );
  }
}
