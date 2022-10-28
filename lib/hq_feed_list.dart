import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class WaterfallsFlowModel {
  String imageUrl;
  String content;
  String like;
  double? imageHeight;
  WaterfallsFlowModel(this.imageUrl, this.content, this.like, this.imageHeight);
}

///瀑布流组件

class WaterfallsWidget extends StatelessWidget {
  final int index;
  final WaterfallsFlowModel model;
  WaterfallsWidget({super.key, required this.index, required this.model});

  @override
  Widget build(BuildContext context) {
    double imgWidth = (MediaQuery.of(context).size.width - 4) / 2.0;
    var img = Image.network(
      model.imageUrl,
      width: imgWidth,
      // height: model.imageHeight,
      fit: BoxFit.fitWidth,
      // alignment: Alignment.topCenter,
    );
    var cell = Column(
      children: [
        Container(
          child: img,
          height: model.imageHeight,
          color: Colors.green,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 8),
          child: Text(model.content,
              // 超出行数显示....
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(color: Colors.black)),
          alignment: Alignment.centerLeft,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Text('${model.like} 赞',
              style: TextStyle(
                color: Colors.red,
              )),
          alignment: Alignment.centerLeft,
        )
      ],
    );
    return Container(child: cell, color: Colors.white);
  }
}

class FeedListViewPage extends StatefulWidget {
  FeedListViewPage({Key? key}) : super(key: key);

  @override
  FeedListViewPageState createState() => FeedListViewPageState();
}

class FeedListViewPageState extends State<FeedListViewPage> {
  List<String> imgList = [
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
    'https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d1977427a239b033b5bb50c05?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto',
  ];

  List<WaterfallsFlowModel> modelList = <WaterfallsFlowModel>[];
  List<Widget> feedList = <Widget>[];

  @override
  void initState() {
    super.initState();

    var i = 0;
    imgList.forEach((imageUrl) {
      var content = i.isEven ? '人物介绍人物介绍人物介绍人物介绍人物介绍人物介绍人物介绍' : '商品介绍';
      double height = i.isEven ? 230 : 200;
      String tag = i.isEven ? '100' : '80';
      var model = WaterfallsFlowModel(
        imageUrl,
        content,
        tag,
        height,
      );
      modelList.add(model);
      i++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('FeedList'),
        ),
        body: WillPopScope(
          child: Container(
              color: Color.fromARGB(255, 228, 222, 222),
              child: MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                itemCount: modelList.length,
                itemBuilder: (context, index) {
                  return WaterfallsWidget(
                    key: Key('$index'),
                    index: index,
                    model: modelList[index],
                    // extent: (index % 5 + 1) * 100,
                  );
                },
              )),
              // 监听返回3
          onWillPop: () async {
            // 点击返回按钮时触发，返回false，将阻止返回，返回true仅阻止手势测滑返回
            return true;
          },
        ));
  }
}
