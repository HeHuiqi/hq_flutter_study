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
    final ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(dataLoader, receivePort.sendPort);

    // The 'echo' isolate sends its SendPort as the first message.
    final SendPort sendPort = await receivePort.first as SendPort;

    final List<dynamic> msg = await sendReceive(
      sendPort,
      'https://jsonplaceholder.typicode.com/posts',
    );

    setState(() {
      data = msg;
    });
  }

  // The entry point for the isolate.
  static Future<void> dataLoader(SendPort sendPort) async {
    // Open the ReceivePort for incoming messages.
    final ReceivePort port = ReceivePort();

    // Notify any other isolates what port this isolate listens to.
    sendPort.send(port.sendPort);

    await for (final dynamic msg in port) {
      final String url = msg[0] as String;
      final SendPort replyTo = msg[1] as SendPort;

      final Uri dataURL = Uri.parse(url);
      final http.Response response = await http.get(dataURL);
      // Lots of JSON to parse
      // List<Map<String, dynamic>> list =  jsonDecode(response.body) as List<Map<String, dynamic>>;
      // print('response.body:${response.body}');
      List<dynamic> list =  jsonDecode(response.body);

      replyTo.send(list);
    }
  }

  Future<dynamic> sendReceive(SendPort port, String msg) {
    final ReceivePort response = ReceivePort();
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
    return ListView.separated(itemBuilder: (context, index) {
      return getRow(index);
    },separatorBuilder: (context, index) {
      return Divider(color: Colors.blue,);
    },itemCount: data.length);
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