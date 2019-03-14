import 'package:flutter/material.dart';
import './hq_list_word.dart';
class HqLoginPage extends StatefulWidget {
  @override
  _HqLoginPageState createState() => _HqLoginPageState();
}

class _HqLoginPageState extends State<HqLoginPage> {
   //密码的控制器
  TextEditingController nameController = TextEditingController();
  //密码的控制器
  TextEditingController passController = TextEditingController();
  _enterHome(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context){
          return RandomWords();
        }
      )
    );
  }
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: AppBar(
        title: new Text('登录'),
      ),
      body: new Container(
        padding: EdgeInsets.only(left: 20,right: 30),
        //用ScrollView包裹防止出现 “A RenderFlex overflowed by xxx pixels on the bottom” 的问题
        child: SingleChildScrollView(
          child: new Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 100)),
          new Text('Flutter欢迎你',style: TextStyle(fontSize: 20,color: Colors.blue),),
          Padding(padding: EdgeInsets.only(top: 20)),
           new TextField(
             controller: nameController,
             keyboardType: TextInputType.emailAddress,
             autofocus: false,
             maxLength: 5,
             maxLengthEnforced: false,
             decoration: InputDecoration(
               contentPadding: EdgeInsets.all(10),
               labelText: '姓名',
               hintText: '你的名字',
               helperText: '',
               icon: Icon(Icons.people),
               border: OutlineInputBorder()
             ),
           ),
           new TextField(
             keyboardType: TextInputType.emailAddress,
             autofocus: false,
             obscureText: true,
             controller: passController,
             decoration: InputDecoration(
               contentPadding: EdgeInsets.all(10),
               labelText: '密码',
               hintText: '你的密码',
               helperText: '',
               icon: Icon(Icons.lock),
               border: OutlineInputBorder(),
               suffixIcon: IconButton(icon:Icon(Icons.clear),onPressed: (){
                 passController.clear();
                 },)
                ,
             ),
           ),
           Container(
             height: 46,
             child: RaisedButton(
               padding: new EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0, bottom: 10.0),
                child: new Flex(
                  mainAxisAlignment: MainAxisAlignment.center,
                  direction: Axis.horizontal,
                  children: <Widget>[
                    new Text('登录',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 17),),
                  ],
                ),
                color: Colors.blue,
                onPressed: (){
                  final ps = passController.text;
                  final name = nameController.text;
                  print('\n用户:$name \n密码:$ps');
                    FocusScope.of(context).requestFocus(FocusNode());
                    _enterHome();
                },),
           )
        
        ], 
      ),
        )
      )
    );
  }
}
class HqLoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '登录',
      home: HqLoginPage(),
    );
  }
}