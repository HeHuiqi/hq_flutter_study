import 'dart:math' as math;

import 'package:flutter/material.dart';

class HqLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HqLoginPageState();
  }
}

class HqLoginPageState extends State<HqLoginPage> {
  // 响应空白处的焦点的Node
  FocusNode blankNode = FocusNode();
  List<FocusNode> focusNodes = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  int _currentFocusIndex = 0;

  @override
  void initState() {
    List<TextEditingController> edcs = [nameController, pwdController];
    for (var i = 0; i < edcs.length; i++) {
      FocusNode focusNode = FocusNode();
      focusNode.addListener(focusNodeListener);
      focusNodes.add(focusNode);
      
      super.initState();
    }
  }

  @override
  void dispose() {
    for (var focusNode in focusNodes) {
      focusNode.removeListener(focusNodeListener);
      focusNode.dispose();
    }
    pwdController.dispose();
    nameController.dispose();
    super.dispose();
  }
  //当输入框获取焦点时会调用此回调
  Future<Null> focusNodeListener() async {
    // 用async的方式实现这个listener
    //注意当输入框获取焦点时，在次触发一次渲染，否则toolbar状态不正确
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('登录'),
        ),
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: blankClicked,
                child: createBody(),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              right: 0,
              child: Column(
                children: <Widget>[
                  Flexible(child: Container()),
                  createToolBar()
                ],
              ),
            ),
          ],
        ));
  }

  // 点击了空白的地方
  void blankClicked() {
    // 点击空白页面关闭键盘
    FocusScope.of(context).requestFocus(blankNode);
    setState(() {});
  }

  FocusNode? currentEditingFocusNode() {
    int index = 0;
    for (FocusNode focusNode in focusNodes) {
      if (focusNode.hasFocus) {
        _currentFocusIndex = index;
        return focusNode;
      }
      index++;
    }
    return null;
  }

  void focusNodeAtIndex(int selectIndex) {
    if (selectIndex < focusNodes.length) {
      FocusNode focusNode = focusNodes[selectIndex];
      focusNode.requestFocus();
    }
  }

  Widget createToolBar() {

    FocusNode? currentFocusNode = currentEditingFocusNode();
    if (currentFocusNode == null) {
      return Container(height: 0);
    }
    int currentIndex = _currentFocusIndex;
    bool isFirst = currentIndex == 0;
    bool isLast = currentIndex == (focusNodes.length - 1);
    print('createToolBar-currentIndex:$currentIndex');
    print('createToolBar-isFirst:$isFirst');
    print('createToolBar-isLast:$isLast');

    Widget preBtn = Transform(
        transform: Matrix4.identity()..rotateZ(math.pi), // 旋转的角度
        origin: Offset(10, 10),
        child: Icon(
          Icons.arrow_forward_ios,
          color: isFirst ? Colors.grey : Colors.blue,
          size: 20.0,
        ));
    Widget nextBtn = Icon(
      Icons.arrow_forward_ios,
      color: isLast ? Colors.grey : Colors.blue,
      size: 20,
    );
    return Container(
      height: 40,
      color: Color(0xffeeeeee),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: <Widget>[
          InkWell(
            child: preBtn,
            enableFeedback: !isFirst,
            onTap: () {
              print('<<<<<<');
              // 点击上一个
              if (!isFirst) {
                focusNodeAtIndex(currentIndex - 1);
              }
              //触发一次渲染更新，不然无法获取焦点状态
              // setState(() {});
            },
          ),
          SizedBox(
            width: 40,
          ),
          InkWell(
            child: nextBtn,
            onTap: () {
              print('>>>>>');
              // 点击下一个
              if (!isLast) {
                focusNodeAtIndex(currentIndex + 1);
              }
              //触发一次渲染更新，不然无法获取焦点状态
              // setState(() {});
            },
          ),
          Flexible(
            child: Container(),
          ),
          InkWell(
              child: Text('关闭',
                  style: TextStyle(
                    color: Colors.blue,
                  )),
              onTap: blankClicked),
        ],
      ),
    );
  }

  // 创建展示内容
  Widget createBody() {
    return ListView(
      padding: EdgeInsets.only(left: 20, right: 20),
      children: <Widget>[
        SizedBox(height: 30),
        createInputText(
            controller: nameController,
            index: 0,
            hint: '请输入用户名',
            icon: Icons.people,
            isCreateInput: true),
        SizedBox(height: 30),
        createInputText(
            controller: pwdController,
            index: 1,
            hint: '请输入密码',
            icon: Icons.power,
            obscureText: true,
            isCreateInput: true),
        SizedBox(height: 30),
        MaterialButton(
          color: Colors.blue,
          child: Text('登录'),
          onPressed: checkLogin,
        )
      ],
    );
  }

  // 创建输入行
  Widget createInputText(
      {required TextEditingController controller,
      required int index,
      obscureText: false,
      String? hint,
      IconData? icon,
      required bool isCreateInput}) {
    FocusNode focusNode = focusNodes[index];
    // 输入框
    TextField textField = TextField(
        controller: controller,
        autofocus: index==0,
        focusNode: focusNode,
        keyboardType: TextInputType.text,
        // onTap: (() {
        //   //触发一次渲染更新，不然无法获取焦点状态
        //   setState(() {});
        // }),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10.0),
          hintText: hint,
        ),
        obscureText: obscureText,
        keyboardAppearance: Brightness.light);
    List<Widget> rowList = [];
    // 输入框前的提示图标
    rowList.add(SizedBox(width: 10));
    rowList.add(Icon(icon));
    // 输入框
    rowList.add(Expanded(child: textField));

    return Row(children: rowList);
  }

  // 点击登录处理
  void checkLogin() {
    print(nameController.text);
    print(pwdController.text);
  }
}
