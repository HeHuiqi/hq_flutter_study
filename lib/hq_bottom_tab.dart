import 'package:flutter/material.dart';


class HqTabApp extends StatelessWidget {
  const HqTabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: HqTabExample(),
    );
  }
}

class HqTabExample extends StatefulWidget {
  const HqTabExample({super.key});

  @override
  State<HqTabExample> createState() => _HqTabExampleState();
}

class _HqTabExampleState extends State<HqTabExample> {
 
  int _selectedIndex = 0;
  final PageController pageController = PageController(initialPage: 0);
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
   @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      pageController.animateToPage(index,duration: Duration(milliseconds: 300),curve: Curves.easeIn);
    });
  }

  Widget _buildCenterBody(int index){
    return PageView(
      /// [PageView.scrollDirection] defaults to [Axis.horizontal].
      /// Use [Axis.vertical] to scroll vertically.
      controller: pageController,
      onPageChanged: (value) {
        setState(() {
          _selectedIndex = value;
        });
      },
      children: const <Widget>[
        Center(
          child: Text('First Page'),
        ),
        Center(
          child: Text('Second Page'),
        ),
        Center(
          child: Text('Third Page'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HqTabApp'),
      ),
      body: Center(
        child: _buildCenterBody(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
