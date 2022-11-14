import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HqIsolatePage extends StatefulWidget {
  const HqIsolatePage({super.key});

  @override
  State<HqIsolatePage> createState() => _HqIsolatePageState();
}

class _HqIsolatePageState extends State<HqIsolatePage> {
  List<dynamic> data = <dynamic>[];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  bool get showLoadingDialog => data.isEmpty;

  Future<void> loadData() async {
    // 每个Isolate都有自己独立的空间和事件循环
    // flutter 应用启动后，会创建一个主Isolate
    // 相当于主进程和子进程一样，但是这里的子进程不共享主进程的空间，用于自己独立的空间，类似于沙盒
    // 不同ioslate之间可以使用ReceivePort相互访问 
    // 创建不同Isolate之间沟通的桥梁
    final ReceivePort receivePort = ReceivePort();
    //开启一个Isolate拥有自己独立的空间执行任务，并传递主Isolate接收信息的端口
    await Isolate.spawn(dataLoader, receivePort.sendPort);

    // The 'echo' isolate sends its SendPort as the first message.
    final SendPort sendPort = await receivePort.first as SendPort;
    print('loadData-sendPort:${sendPort.hashCode}');
    final List<dynamic> rspMsg = await sendReceive(
      'https://jsonplaceholder.typicode.com/posts',
      sendPort,
    );

    setState(() {
      data = rspMsg;
    });
  }

  // The entry point for the isolate.
  static Future<void> dataLoader(SendPort sendPort) async {
    // Open the ReceivePort for incoming messages.
    // 打开一个端口接收其他isolate的消息
    final ReceivePort port = ReceivePort();

    // Notify any other isolates what port this isolate listens to.

    //向其他的isolate发送我接受信息的端口
    sendPort.send(port.sendPort);
    print('dataLoader-sendPort:${sendPort.hashCode}');

    //处理接受到的信息
    await for (final dynamic receivedMsg in port) {
      print("dataLoader-receivedMsg:$receivedMsg");
      final String url = receivedMsg[0] as String;
      final SendPort replyTo = receivedMsg[1] as SendPort;
      final Uri dataURL = Uri.parse(url);
      final http.Response response = await http.get(dataURL);
      List<dynamic> list = jsonDecode(response.body);
      print('dataLoader-replyTo:${replyTo.hashCode}');

      replyTo.send(list);
    }
  }

  Future<dynamic> sendReceive( String msg,SendPort port) {
    print('sendReceive-port:${port.hashCode}');
    final ReceivePort response = ReceivePort();
    //使用port向其他Isolate发送信息
    port.send([msg, response.sendPort]);
    return response.first;
  }

  Widget getBody() {
    bool showLoadingDialog = data.isEmpty;

    if (showLoadingDialog) {
      return getProgressDialog();
    } else {
      return getListView();
    }
  }

  Widget getProgressDialog() {
    return const Center(child: CircularProgressIndicator());
  }

  ListView getListView() {
    return ListView.separated(
        itemBuilder: (context, index) {
          return getRow(index);
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.blue,
          );
        },
        itemCount: data.length);
  }

  Widget getRow(int i) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text("Row id:${data[i]["id"]}, title: ${data[i]["title"]}"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HqIsolatePage'),
      ),
      body: getBody(),
    );
  }
}
