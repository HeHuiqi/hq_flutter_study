import 'package:flutter/material.dart';
import 'hq_global_key.dart';
class HqAlertPage extends StatefulWidget {
  const HqAlertPage({super.key});

  @override
  State<HqAlertPage> createState() => _HqAlertPageState();
}

class _HqAlertPageState extends State<HqAlertPage> {
  late AboutDialog bgd;
  AlertDialog _alertDialog() {
    return AlertDialog(
      content: Text('一个警告！'),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('close')),
        ElevatedButton(
            onPressed: () {
              // Navigator.of(context).pop();
              //全屏弹出
              Navigator.of(context)
                ..pop()
                ..push(MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (builder) {
                      return HqAlertPage();
                    }));
            },
            child: Text('show'))
      ],
    );
  }

  SimpleDialog _simpleDialog() {
    return SimpleDialog(
      title: Text('Add Info'),
      children: [
        SimpleDialogOption(
          child: Text('A'),
        ),
        SimpleDialogOption(
          child: Text('C'),
        ),
        SimpleDialogOption(
          child: Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  void _showSheet(BuildContext context, int index) {
    Widget _bulidSheetItem(String title) {
      return ListTile(
        title: Text(title),
        textColor: Colors.pink,
        onTap: () {
          Navigator.of(context).pop();
          print('您选择了：$title');
        },
      );
    }

    showModalBottomSheet(
        // 点击背景是否消失
        isDismissible: true,
        // 设置后面的背景色
        barrierColor: Color.fromARGB(150, 87, 22, 153),
        // 设置内容背景色
        backgroundColor: Color.fromARGB(255, 77, 133, 194),
        context: context,
        builder: ((context) {
          return Wrap(
            children: [
              _bulidSheetItem('苹果'),
              _bulidSheetItem('香蕉'),
              _bulidSheetItem('葡萄'),
              _bulidSheetItem('西瓜'),
            ],
          );
        }));
  }

  void _hqShowView(BuildContext context, int index) {
    print('index:$index');
    if (index == 3) {
      showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1990, 1),
              lastDate: DateTime.now())
          .then((date) {
        print('选择的日期：$date');
      });
      return;
    }
    if (index == 4) {
      _showSheet(context, index);
      return;
    }

   showDialog(
        //设置背景色
        // barrierColor: Colors.green[200],
        //使用全局key来弹出
        context: navigatorStateKey.currentState!.context,
        // context: context,
        //点击背景不消失
        barrierDismissible: false,
        builder: ((BuildContext context) {
          if (index == 1) {
            return _simpleDialog();
          }
          if (index == 2) {
            return AboutDialog(
              applicationName: 'MyStudy',
              applicationVersion: 'v1.0.0',
              applicationIcon: Icon(
                Icons.accessibility_outlined,
                color: Theme.of(context).primaryColor,
              ),
            );
          }
          return _alertDialog();
        }));
  }

  Widget _buildListItem(String title, int index, BuildContext context) {
    return Column(
      children: [
        ListTile(
            onTap: () {
              _hqShowView(context, index);
            },
            leading: CircleAvatar(child: Text((index + 1).toString())),
            title: Text(title)),
        const Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> itemTitles = [
      'AlertDialog',
      'SimpleDialog',
      'AboutDialog',
      'DatePicker',
      'BottomSheet',
    ];
    return Scaffold(
        appBar: AppBar(title: Text('Alert')),
        body: Center(
            child: ListView.builder(
                itemCount: itemTitles.length,
                itemBuilder: (context, index) {
                  return _buildListItem(itemTitles[index], index, context);
                })));
  }
}
