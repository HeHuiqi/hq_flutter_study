import 'package:flutter/material.dart';
import 'package:hq_study/hq_%20locale_provider.dart';
import 'package:hq_study/hq_app_const.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'gen_l10n/app_localizations.dart';

class HqIntlPage extends StatefulWidget {
  const HqIntlPage({super.key});

  @override
  State<HqIntlPage> createState() => _HqIntlPageState();
}

class _HqLocalCheck extends StatelessWidget {
  bool isCheck;
  String title;
  _HqLocalCheck({super.key, required this.title, required this.isCheck});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        isCheck
            ? Icon(
                Icons.check,
                color: Colors.blue,
                size: 30,
              )
            : Container(
                width: 30,
                height: 30,
              ),
      ],
    );
  }
}

class _HqIntlPageState extends State<HqIntlPage> {
  int localIndex = HqLocalLanguageIndex.en.hqIndex;
  @override
  void initState() {
    super.initState();
    initLocalIndex();
  }

  void initLocalIndex() async {
    final prefs = await SharedPreferences.getInstance();
   localIndex = prefs.getInt('kLocalIndex') ?? 0;
  }

  Widget _simpleDialog(StateSetter setState) {
    return SimpleDialog(
      title: Text(
        '语言设置',
        textAlign: TextAlign.center,
      ),
      children: [
        SimpleDialogOption(
          child: _HqLocalCheck(
            title: '简体中文',
            isCheck: localIndex == HqLocalLanguageIndex.zh.hqIndex,
          ),
          onPressed: () {
            checkClick(setState, 1);
          },
        ),
        SimpleDialogOption(
          child: _HqLocalCheck(
            title: 'English',
            isCheck: localIndex == HqLocalLanguageIndex.en.hqIndex,
          ),
          onPressed: () {
            checkClick(setState, 0);
          },
        ),
        SimpleDialogOption(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              child: Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('确定'),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                final saveSuc = await prefs.setInt('kLocalIndex', localIndex);
                //获取提供者
                HqLocaleProvider localeProvider =
                    context.read<HqLocaleProvider>();
                //改变值，触发通知
                localeProvider.setLocaleIndex(localIndex);
                Navigator.of(context).pop();
              },
            )
          ],
        ))
      ],
    );
  }

  void checkClick(StateSetter setState, int index) {
    setState(() {
      localIndex = index;
    });
  }

  void _showLocalSet() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return _simpleDialog(setState);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations local = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(local.internationalization),
        actions: [
          IconButton(
              onPressed: () {
                _showLocalSet();
              },
              icon: Icon(Icons.settings)),
        ],
      ),
      body: _HqBody(),
    );
  }
}

class _HqBody extends StatefulWidget {
  const _HqBody({super.key});

  @override
  State<_HqBody> createState() => __HqBodyState();
}

class __HqBodyState extends State<_HqBody> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations local = AppLocalizations.of(context);
    List items = [
      local.helloWorld,
      local.homeTitle,
      local.save,
      local.study,
    ];

    return Container(
      child: ListView.builder(
        itemCount: items.length,
        prototypeItem: ListTile(
          title: Text("items.first"),
        ),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
          );
        },
      ),
    );
  }
}
