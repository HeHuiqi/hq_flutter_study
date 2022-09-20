import 'package:flutter/material.dart';

class HqInputHandlePage extends StatefulWidget {
  const HqInputHandlePage({super.key});

  @override
  State<HqInputHandlePage> createState() => _HqInputHandlePageState();
}

class _HqInputHandlePageState extends State<HqInputHandlePage> {
  FocusNode _nextFocusNode = FocusNode();
  FocusNode _customFocusNode = FocusNode();
  String customTextInit = 'init:';
  //这个来控制文本
  TextEditingController _nameEditController = TextEditingController();
  TextEditingController _passwordEditController = TextEditingController();
  @override
  void initState() {
    _nameEditController.addListener(() {
      print("_nameEditController:${_nameEditController.text}");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Input Handle')),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: ListView(children: [
            SizedBox(
              height: 40,
            ),
            TextField(
              controller: _nameEditController,
              cursorColor: Colors.red,
              style: TextStyle(
                color: Colors.purple,
              ),
              autofocus: true,
              toolbarOptions: ToolbarOptions(selectAll: false),
              //是否禁止长按选择
              // enableInteractiveSelection: false,
              // keyboardAppearance: Brightness.dark,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.usb,
                  color: Colors.red,
                ),
                labelText: 'UserName',
                suffixIcon: IconButton(
                    onPressed: (() {
                      _nameEditController.clear();
                    }),
                    icon: Icon(Icons.close)),
                labelStyle: TextStyle(
                  color: Colors.orange,
                ),
                // border: InputBorder.none,
                enabledBorder: const OutlineInputBorder(
                  // width: 0.0 produces a thin "hairline" border
                  borderSide: const BorderSide(color: Colors.green, width: 0.0),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 0.5),
                    borderRadius: BorderRadius.all(Radius.circular(40))),
              ),
              onChanged: (value) {
                print('onChanged: $value');
              },
              onEditingComplete: () {
                print('onEditingComplete');
              },
              onSubmitted: (value) {
                print('onSubmitted: $value');
                print('_nextFocusNode:${_nextFocusNode.hasFocus}');
                //让某个输入框获取焦点
                FocusScope.of(context).requestFocus(_nextFocusNode);
              },
            ),
            SizedBox(
              height: 15,
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                //包装一个容器来改变输入框的高度
                child: Container(
                    color: Color.fromARGB(255, 133, 182, 134),
                    height: 40,
                    child: TextField(
                      controller: _passwordEditController,
                      // cursorHeight: 10,
                      //是否安全输入
                      obscureText: true,
                      focusNode: _nextFocusNode,
                      //设置输入样式
                      style: TextStyle(fontSize: 20),
                      cursorColor: Colors.yellow,
                      decoration: InputDecoration(
                        //设置提示字符传和样式
                        hintText: 'Password',
                        hintStyle:
                            TextStyle(color: Colors.purple, fontSize: 20),
                        contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                        //设置右边配件icon
                        suffixIcon: Container(
                          color: Colors.red,
                          width: 14,
                          height: 14,
                          child: new IconButton(
                            padding: const EdgeInsets.all(0.0),
                            icon: Icon(
                              Icons.close,
                              color: Colors.yellow,
                            ),
                            onPressed: () {
                              setState(() {
                                //清空文本
                                _passwordEditController.clear();
                              });
                            },
                          ),
                        ),
                        // 设置默认边框可用状态下的，enable=true
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        //设置获取焦点/光标后的边框
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      //点击完成或按下enter
                      onSubmitted: (value) {
                        print('_nextFocusNode:${_nextFocusNode.hasFocus}');
                        //是输入框失去焦点
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    ))),
            ElevatedButton(
                onPressed: () {
                  //让某个输入框获取焦点
                  FocusScope.of(context).requestFocus(_nextFocusNode);
                },
                child: Text('密码获取焦点')),
            KeyboardListener(focusNode: _customFocusNode , 
            onKeyEvent: (value) {
                // print('${value}');
                print('customTextInit:$customTextInit');
                if (value.logicalKey.keyId == 0x100000008 && customTextInit != 'init:') {
                  customTextInit = customTextInit.substring(0,customTextInit.length-1);
                }else{
                  if (value.logicalKey.keyId != 0x100000008) {
                    customTextInit += value.character ?? ''; 
                  }
                }
                
              setState(() {
              
              });
            },
            child: TextButton(child: Text(customTextInit), onPressed: () {
              FocusScope.of(context).requestFocus(_customFocusNode);
            },)),
          ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameEditController.dispose();
    _passwordEditController.dispose();
    super.dispose();
  }
}
