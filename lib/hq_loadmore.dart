// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, prefer_is_empty, slash_for_doc_comments, unnecessary_brace_in_string_interps, prefer_const_constructors_in_immutables, prefer_final_fields


import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class LoadMorePage extends StatefulWidget {
  LoadMorePage({Key? key}) : super(key: key);

  @override
  _LoadMorePageState createState() => _LoadMorePageState();
}

class _LoadMorePageState extends State<LoadMorePage> {
  ScrollController _scrollController = ScrollController(); //listview 的控制器
  List _list = [];
  int _page = 1;
  bool isLoading = false;

  var json; //是否正在加载数据
  @override
  void initState() {
    super.initState();
    //之所以写三遍是因为我发现接口中每一页数据较少，第一次加载一页达不到底部，监听不到滑动
    _getData();
    // _getData();
    // _getData();
    // print("到达了最底部。。。");
    //下面这个方法每次都底部都会执行，上面的代码只会执行一次
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 20) {
        print('滑动到了最底部');
        _getData();
      }
    });
  }

  _getData() async {
    var apiUrl = "https://jsonplaceholder.typicode.com/posts/${_page}/comments";
    Response result = await Dio().get(apiUrl);
// print(json.decode(result.data)["result"]);
    setState(() {
      _list.addAll(result.data);
      _page++;
    });
  }

/**
* 加载更多时显示的组件,给用户提示
*/
  Widget _getMoreWidget() {
    return  Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '加载中...',
              style: TextStyle(fontSize: 16.0),
            ),
            CircularProgressIndicator(
              strokeWidth: 1.0,
            )
          ],
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    print('执行刷新');
// this._getData();
    await Future.delayed(Duration(seconds: 3), () {
      print('refresh');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("请求数据"),
        ),
        body: _list.length > 0
            ? RefreshIndicator(
                onRefresh: _onRefresh,
                child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                    itemCount: _list.length,
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      if (index == _list.length - 1) {
                        return Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(_list[index]["email"], maxLines: 1),
                            ),
                            Divider(),
                            //如果条目达到最底部，则还要展示一个加载圈
                            _getMoreWidget()
                          ],
                        );
                      } else {
                        //没有到达底部直接加载条目
                        return Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(_list[index]["email"], maxLines: 1),
                            ),
                            Divider()
                          ],
                        );
                      }
                    }))
            : _getMoreWidget());
  }
}
