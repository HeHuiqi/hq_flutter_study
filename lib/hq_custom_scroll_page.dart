import 'package:flutter/material.dart';

class HqCustomScrollViewPage extends StatefulWidget {
  const HqCustomScrollViewPage({super.key});

  @override
  State<HqCustomScrollViewPage> createState() => _HqCustomScrollViewPageState();
}

class _HqCustomScrollViewPageState extends State<HqCustomScrollViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HqCustomScrollview'),
      ),
      body: Container(
        child: HqCustomScrollView(),
      ),
    );
  }
}

class HqCustomScrollView extends StatefulWidget {
  const HqCustomScrollView({super.key});

  @override
  State<HqCustomScrollView> createState() => _HqCustomScrollViewState();
}

class _HqCustomScrollViewState extends State<HqCustomScrollView> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 230.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('复仇者联盟'),
            background: Image.network(
              'http://img.haote.com/upload/20180918/2018091815372344164.jpg',
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        SliverGrid.count(
          crossAxisCount: 4,
          children: List.generate(8, (index) {
            return Container(
              color: Colors.primaries[index % Colors.primaries.length],
              alignment: Alignment.center,
              child: Text(
                '$index',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            );
          }).toList(),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((content, index) {
            return Container(
              height: 85,
              alignment: Alignment.center,
              color: Colors.primaries[index % Colors.primaries.length],
              child: Text(
                '$index',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            );
          }, childCount: 25),
        )
      ],
    );
  }
}
