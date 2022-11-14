import 'package:flutter/material.dart';
import 'package:hq_study/hq_app_const.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hq_study/hq_bottom_tab.dart';
import 'package:hq_study/hq_layout_app.dart';
// import 'package:intl/locale.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'hq_gridview_page.dart';
import 'hq_alert_page.dart';
import 'hq_my_profile.dart';
// import 'hq_loadmore.dart';
import 'hq_constraint.dart';
import 'hq_base.dart';
import 'hq_tab.dart';
import 'hq_logo_animation.dart';
import 'hq_office_animation.dart';
import 'hq_office_page_animation.dart';
import 'hq_animation_widget.dart';
import 'hq_hero_animation.dart';
import 'hq_state_manage.dart';
import 'hq_listview.dart';
import 'hq_pull_refresh.dart';
import 'hq_input_handle.dart';
import 'hq_global_key.dart';
import 'hq_focus_demo.dart';
import 'hq_custom_ps_input.dart';
import 'hq_login_page.dart';
import 'hq_key_board_toolbar.dart';
import 'hq_gesture_detector.dart';
import 'hq_animation.dart';
import 'hq_custom_scroll_page.dart';
import 'hq_provider_page.dart';
import 'hq_json.dart';
import 'hq_tab_badge.dart';
import 'hq_feed_list.dart';
import 'hq_user_info.dart';
import 'hq_video.dart';
import 'hq_painter.dart';
import 'hq_paint_dashboard.dart';
import 'hq_start_page.dart';
import 'hq_text.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'gen_l10n/app_localizations.dart';
import 'hq_intl.dart';
import 'hq_ locale_provider.dart';
import 'hq_painter_sign.dart';
import 'hq_isolate.dart';



class HqStudyApp extends StatefulWidget {
  const HqStudyApp({super.key});

  @override
  State<HqStudyApp> createState() => _HqStudyAppState();
}
class _HqStudyAppState extends State<HqStudyApp> {
  int localIndex = HqLocalLanguageIndex.zh.hqIndex;
  _initLocalIndex() async {
    final prefs = await SharedPreferences.getInstance();
    localIndex = prefs.getInt('kLocalIndex') ?? 0;
    print('_initLocalIndex:$localIndex');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initLocalIndex();
  }

  @override
  Widget build(BuildContext context) {
    // 监听变化
    return ChangeNotifierProvider(
      create: (context) {
        return HqLocaleProvider();
      },
      builder: (context, child) {
        //订阅local变化
        return Consumer<HqLocaleProvider>(
            builder: (context, localProvider, child) {
              localIndex = localProvider.localIndex < 0 ? localIndex:localProvider.localIndex;
          return MaterialApp(
            // 设置全局唯一key，可以中用 navigatorStateKey.currentState.push()来做路由跳转了
            navigatorKey: navigatorStateKey,
            // 配置国际化代理
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            //默认语言
            locale: AppLocalizations.supportedLocales[localIndex],
            home: HqStudyList(),
          );
        });
      },
    );

    // MaterialApp(
    //   // 设置全局唯一key，可以中用 navigatorStateKey.currentState.push()来做路由跳转了
    //   navigatorKey: navigatorStateKey,
    //   // 配置国际化代理
    //   localizationsDelegates: AppLocalizations.localizationsDelegates,
    //   supportedLocales: AppLocalizations.supportedLocales,
    //   //默认语言
    //   locale: AppLocalizations.supportedLocales[1],
    //   home: HqStudyList(),
    // );
  }
}



class HqStudyList extends StatefulWidget {
  const HqStudyList({super.key});

  @override
  State<HqStudyList> createState() => _HqStudyListState();
}

class _HqStudyListState extends State<HqStudyList> {

  @override
  Widget build(BuildContext context) {
        AppLocalizations local = AppLocalizations.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(local.homeTitle),
        ),
        body: HqBody());
  }
}

class HqBody extends StatefulWidget {
  final List<Widget> studyItems = [
    HqIsolatePage(),
    HqPainterSignPage(),
    HqIntlPage(),
    HqTextPage(),
    HqStartPage(),
    HqPainterPage(),
    HqPaintDashBoard(),
    HqUserInfoPage(),
    HqVideoPage(),
    HqTabsComponentPage(),
    FeedListViewPage(),
    HqJsonPage(),
    HqGridViewPage(),
    HqAlertPage(),
    HqProviderPage(),
    HqCustomScrollViewPage(),
    HqBottomDrawerPage(),
    HqAnimationPage(),
    HqCustomPasswodInputPage(),
    HqLoginPage(),
    HqLoginToolBarPage(),
    HqLayoutApp(),
    HqFocusDemoPage(),
    HqInputHandlePage(),
    HqListTileSelectPage(),
    HqTabApp(),
    HqTabPage(),
    HqBasePage(),
    HqProfilePage(),
    HqConstraintPage(),
    HqLogoMoveAnimationPage(),
    HqAnimatedWidgetApp(),
    HqCustomRouteAnimationPage(),
    HqPhysicsCardDragDemo(),
    HqHeroAnimationPage(),
    HqStateManagePage(),
    HqPullToRefreshPage(),
  ];
  HqBody({super.key});

  @override
  State<HqBody> createState() => _HqBodyState();
}

class _HqBodyState extends State<HqBody> {
  Future<void> _refresh() {
    return Future.delayed(Duration(seconds: 2));
  }

  int index = 0;
  HqStudyItem _createItem(String title, int index) {
    return HqStudyItem(
        title: title, index: index, page: widget.studyItems[index - 1]);
  }

  bool isScrollTopBottom = false;

  ScrollController _scrollController = ScrollController();

  List<HqStudyItem> _createItems() {
    List<HqStudyItem> _items = [];
    for (var i = 0; i < widget.studyItems.length; i++) {
      final _item =
          this._createItem(widget.studyItems[i].runtimeType.toString(), i + 1);
      _items.add(_item);
    }
    return _items;
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      // print('滑动:${_scrollController.position.pixels}');
      // print('滑动:${_scrollController.offset}');
      // print('max-content:${_scrollController.position.maxScrollExtent}');
      if (_scrollController.position.maxScrollExtent > 0 &&
          _scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent + 20) {
        // print('滑动到了最底部');
        setState(() {
          isScrollTopBottom = true;
        });
      } else {
        setState(() {
          isScrollTopBottom = false;
        });
      }
      // print('isbottom:$isScrollTopBottom');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            children: _createItems(),
          ),
        )),
        isScrollTopBottom ? Text('footer') : Container(),
      ],
    );
  }
}

class HqStudyItem extends StatelessWidget {
  final int index;
  final String title;
  final Widget page;
  const HqStudyItem(
      {super.key,
      required this.index,
      required this.title,
      required this.page});
  String _indexToString() {
    return this.index.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            child: Text(_indexToString()),
          ),
          title: Text(this.title),
          trailing: Icon(
            Icons.arrow_forward_ios_sharp,
            color: Colors.blue,
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return this.page;
            }));
          },
        ),
        const Divider(height: 1.0),
      ],
    );
  }
}
