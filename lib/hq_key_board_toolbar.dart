import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui';

class HqLoginToolBarPage extends StatefulWidget {
  const HqLoginToolBarPage({super.key});

  @override
  State<HqLoginToolBarPage> createState() => _HqLoginToolBarPageState();
}

class _HqLoginToolBarPageState extends State<HqLoginToolBarPage> {
  ScrollController scrollController = ScrollController();
  double maxScrollExtent = 0.0;
  //注意焦点的数量要和输入框的数量要一致
  List<FocusNode> focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode()
  ];
  late HqFocusNodeState focusNodeState;

  void focusNodeListener() {
    //处理输入框焦点事件，获取最新的状态
    focusNodeState = HqFocusNodeState.getFocusNodeState(focusNodes);

    print("window.viewInsets2:${window.viewInsets}");
    print(
        'scrollController.position.maxScrollExtent:${scrollController.position.maxScrollExtent}');
    print('scrollController.offset:${scrollController.offset}');

    /*
    if (focusNodeState.isShowkeyboard) {
      print('focusNodeState.currentNode.size:${focusNodeState.currentNode?.size}');
      print('focusNodeState.currentNode.offset:${focusNodeState.currentNode?.offset}');

      // 48 输入框默认高度，40 toolbar高度
      print('focusNodeState.currentIndex:${focusNodeState.currentIndex}');
      double offset = 48.0 * (focusNodeState.currentIndex + 1) + 40;
      // if (offset > scrollController.position.maxScrollExtent) {
      //   offset = scrollController.position.maxScrollExtent;
      // }
      // offset = 0.0;
      // offset =   0;
      print('offset:$offset');
      scrollController.animateTo(offset,
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    } else {
      scrollController.animateTo(0,
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    }
    */

    //触发渲染
    setState(() {
      if (focusNodeState.isShowkeyboard) {
        print(
            'focusNodeState.currentNode.size:${focusNodeState.currentNode?.size}');
        print(
            'focusNodeState.currentNode.offset:${focusNodeState.currentNode?.offset}');

        // 48 输入框默认高度，40 toolbar高度
        print('focusNodeState.currentIndex:${focusNodeState.currentIndex}');
        double offset = 48.0 * (focusNodeState.currentIndex + 1) + 40;
        double dy = focusNodeState.currentNode?.offset.dy ?? 0.0;
        // offset = -(dy-520);
        // offset = dy > 147 ? dy-147:147;
        // if (offset > scrollController.position.maxScrollExtent) {
        //   offset = scrollController.position.maxScrollExtent;
        // }
        // offset = 0.0;
        // offset =   0;
        print('offset:$offset');
        if (offset > 0 && dy / 2.0 > 147) {
          scrollController.animateTo(offset,
              duration: Duration(milliseconds: 300), curve: Curves.easeIn);
        }
      } else {
        scrollController.animateTo(0,
            duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      }
    });
  }

  @override
  void initState() {
    print("window.viewInsets:${window.viewInsets}");
    print("window.padding:${window.padding}");

    print("window.devicePixelRatio:${window.devicePixelRatio}");
    print("window.physicalSize:${window.physicalSize}");
    // print("window.physicalGeometry:${window.physicalGeometry}");
    // scrollController.addListener(() {
    //   // maxScrollExtent = scrollController.position.maxScrollExtent;
    //   // print('maxScrollExtent:$maxScrollExtent');
    //  });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});

    focusNodeState = HqFocusNodeState(isShowkeyboard: false);
    //为每个焦点添加监听
    HqFocusNodeState.addFocusNodeLisenters(focusNodes, focusNodeListener);
    //可以添加多个监听器
    focusNodes[0].addListener(() {});
    // window.onMetricsChanged = (() {
    //   // print('onMetricsChanged');
    //   // print("window.viewInsets.bottom:${window.viewInsets.bottom}");
    // });
    super.initState();
  }

  @override
  void dispose() {
    //要清除每个焦点的监听
    HqFocusNodeState.removeFocusNodeLisenters(focusNodes, focusNodeListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('HqLoginToolBar'),
        ),
        //Stack布局很关键
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              right: 0,
              child: ListView(
                padding: EdgeInsets.only(top: 0),
                controller: scrollController,
                children: [
                  HqInputView(
                    hintText: '输入用户名',
                    focusNode: focusNodes[0],
                    autofocus: false,
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  ),
                  HqInputView(
                    hintText: '输入密码',
                    focusNode: focusNodes[1],
                  ),
                  HqInputView(hintText: '输入激活码', focusNode: focusNodes[2]),
                  HqInputView(hintText: '输入邀请码', focusNode: focusNodes[3]),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
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
              top: 0,
              left: 0,
              bottom: 0,
              right: 0,
              child: HqKeyBoardToolBar(
                keyboardIsShow: focusNodeState.isShowkeyboard,
                preFocusNode: focusNodeState.currentNode,
                nextFocusNode: focusNodeState.nextNode,
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
  final Color? bgcolor;
  final EdgeInsetsGeometry? padding;
  const HqInputView(
      {required this.hintText,
      required this.focusNode,
      this.autofocus = false,
      this.padding = const EdgeInsets.symmetric(horizontal: 20),
      this.bgcolor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: this.bgcolor,
      padding: padding,
      child: TextField(
        autofocus: autofocus,
        focusNode: focusNode,
        decoration: InputDecoration(hintText: hintText),
      ),
    );
  }
}

class HqFocusNodeState {
  FocusNode? currentNode;
  FocusNode? nextNode;
  int currentIndex;
  bool isShowkeyboard = false;
  HqFocusNodeState(
      {this.currentNode,
      this.nextNode,
      required this.isShowkeyboard,
      this.currentIndex = 0});
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
    // print('currentIndex:$currentIndex');
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

  static addFocusNodeLisenters(
      List<FocusNode> nodes, void Function() listener) {
    for (var focusNode in nodes) {
      focusNode.addListener(listener);
    }
  }

  static removeFocusNodeLisenters(
      List<FocusNode> nodes, void Function() listener) {
    for (var focusNode in nodes) {
      focusNode.removeListener(listener);
      focusNode.dispose();
    }
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
      //这里十分关键
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
