import 'package:flutter/material.dart';
import 'package:hq_study/models/hq_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HqUserInfoEditPage extends StatefulWidget {
  final User user;
  HqUserInfoEditPage({super.key, required this.user});

  @override
  State<HqUserInfoEditPage> createState() => _HqUserInfoEditPageState();
}

class _HqUserInfoEditPageState extends State<HqUserInfoEditPage> {
  //通过此对象来控制输入框的文字
  TextEditingController editingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  FocusNode customFocusNode = FocusNode();
  late bool isEditing;
  @override
  void initState() {
    isEditing = true;
    editingController.text = widget.user.username;
    super.initState();
    //监听焦点的变化
    focusNode.addListener(() {
      print('focusNode.hasFocus:${focusNode.hasFocus}');
      setState(() {});
    });
  }

  @override
  void dispose() {
    //释放
    editingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  void didUpdateWidget(covariant HqUserInfoEditPage oldWidget) {
    customFocusNode.requestFocus();
    super.didUpdateWidget(oldWidget);
  }

  var _inputBorder = UnderlineInputBorder(
      borderSide: BorderSide(
    width: 1.0,
    color: Color.fromARGB(255, 224, 220, 219),
  ));
  Widget? _suffixIcon(BuildContext context) {
    if (focusNode.hasFocus) {
      return Container(
          width: 30,
          height: 30,
          // color: Colors.pink,
          child: IconButton(
              padding: EdgeInsets.all(0),
              iconSize: 20,
              onPressed: () {
                editingController.clear();
              },
              icon: Icon(
                Icons.close,
                color: Color.fromARGB(255, 120, 118, 117),
              )));
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EditUserInfo'),
      ),
      body: Center(
          child: GestureDetector(
              onTap: () {
                dismissKeyboard(context);
              },
              child: Container(
                //这里必须设置颜色才会渲染，才能在在内容之外才会触发Tap手势
                color: Color.fromARGB(0, 255, 255, 255),
                child: Column(
                  children: [
                    Container(
                        // color: Color.fromARGB(255, 129, 214, 229),
                        // height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextField(
                          cursorHeight: 20,
                          focusNode: focusNode,
                          controller: editingController,
                          //监听输入变化
                          onChanged: (value) {
                            widget.user.username = value;
                            setState(() {
                              isEditing = true;
                            });
                          },
                          maxLines: 1,
                          //点击键盘Return键时触发，先触发
                          onEditingComplete: () {
                            print('onEditingComplete');
                          },
                          //点击键盘Return键时触发，后触发
                          onSubmitted: (value) {
                            print('onSubmitted');
                            dismissKeyboard(context);
                          },

                          decoration: InputDecoration(
                            hintText: '输入用户名',
                            suffixIcon: _suffixIcon(context),
                            // suffix: _suffixIcon(context),
                            enabledBorder: _inputBorder,
                            focusedBorder: _inputBorder,
                          ),
                        )),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 40),
                            ),
                            onPressed: () async {
                              dismissKeyboard(context);
                              // Navigator.of(context).pop([widget.user]);
                              final prefs =
                                  await SharedPreferences.getInstance();
                              final saveSuc = await prefs.setString(
                                  'kUserInfo', widget.user.toJson());
                              print('saveSuc:$saveSuc');
                              Fluttertoast.showToast(
                                  msg: '保存成功', gravity: ToastGravity.CENTER);
                            },
                            child: Text('Done'))),
                  ],
                ),
              ))),
    );
  }
}
