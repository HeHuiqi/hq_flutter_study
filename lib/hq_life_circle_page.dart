import 'package:flutter/material.dart';
import 'package:hq_study/hq_router_observer.dart';
import 'package:hq_study/hq_temp_page.dart';

class HqLifeCirclePage extends StatefulWidget {
  const HqLifeCirclePage({super.key});

  @override
  State<HqLifeCirclePage> createState() => _HqLifeCirclePageState();
}

class _HqLifeCirclePageState extends State<HqLifeCirclePage>
    with WidgetsBindingObserver, RouteAware {
  int count = 0;
  @override
  void initState() {
    print('initState');
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build');

    return PopScope(
        onPopInvoked: (didPop) {
          print("didPop:$didPop");
        },
        child: Scaffold(
          appBar: AppBar(title: Text('HqLifeCirclePage')),
          body: Container(
            child: Column(
              children: [
                Text('count:$count'),
                if (count % 2 == 0) Text('show me'),
                ElevatedButton(
                    onPressed: (() {
                      setState(() {
                        count = count + 1;
                      });
                    }),
                    child: Text('加1')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return HqTempPage(
                          data: "HqLifeCirclePage",
                        );
                      }));
                    },
                    child: Text("下一页"))
              ],
            ),
          ),
        ));
  }

// RouteAware 监听Route 回调
  @override
  void didPush() {
    super.didPush();
    print('didPush:首次页面显示');
  }

  @override
  void didPushNext() {
    super.didPushNext();
    print('didPushNext:进入下一页面');
  }

  @override
  void didPopNext() {
    super.didPopNext();
    print('didPopNext:由下一级返回时');
  }

  @override
  void didPop() {
    super.didPop();
    print('didPopNext:页面返回');
  }

// WidgetsBindingObserver App的生命周期回调监听
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print("didChangeAppLifecycleState:${state.toString()}");
  }

  @override
  void activate() {
    print('activate');
    super.activate();
  }

  @override
  void didChangeDependencies() {
    print('didChangeDependencies');
    super.didChangeDependencies();
    //注意在这里订阅
    hqRouteObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didUpdateWidget(covariant HqLifeCirclePage oldWidget) {
    print('didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    print('deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('dispose');
    super.dispose();
    //注意取消订阅和监听
    hqRouteObserver.unsubscribe(this);
    WidgetsBinding.instance.removeObserver(this);
  }
}
