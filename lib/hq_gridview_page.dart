import 'package:flutter/material.dart';
import 'hq_global_key.dart';
class HqGridViewPage extends StatefulWidget {
  const HqGridViewPage({super.key});

  @override
  State<HqGridViewPage> createState() => _HqGridViewPageState();
}

class _HqGridViewPageState extends State<HqGridViewPage> {
  Widget _buildCard() {
    return SizedBox(
      height: 210,
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: const Text(
                '1625 Main Street',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: const Text('My City, CA 99984'),
              leading: Icon(
                Icons.restaurant_menu,
                color: Colors.blue[500],
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text(
                '(408) 555-1212',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              leading: Icon(
                Icons.contact_phone,
                color: Colors.blue[500],
              ),
            ),
            ListTile(
              title: const Text('costa@example.com'),
              leading: Icon(
                Icons.contact_mail,
                color: Colors.blue[500],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // #docregion grid
  Widget _buildGrid() => GridView.extent(
      // 设置单元格最大的大小
      maxCrossAxisExtent: 150,
      padding: const EdgeInsets.all(4),
      // 设置行间隙
      mainAxisSpacing: 4,
      // 设置列间隙
      crossAxisSpacing: 4,
      children: _buildGridTileList(30));

  // The images are saved with names pic0.jpg, pic1.jpg...pic29.jpg.
  // The List.generate() constructor allows an easy way to create
  // a list when objects have a predictable naming pattern.
  List<Container> _buildGridTileList(int count) => List.generate(
      count, (i) => Container(child: Image.asset('images/pic$i.jpg')));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HqGridView'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.of(context).pop();
            navigatorStateKey.currentState?.pop();
            
          },
        ),
      ),
      body: Center(
        // child: _buildCard(),
        child: _buildGrid(),
      ),
    );
  }
}
