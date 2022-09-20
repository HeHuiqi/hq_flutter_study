import 'package:flutter/material.dart';

class HqBasePage extends StatefulWidget {
  const HqBasePage({super.key});

  @override
  State<HqBasePage> createState() => _HqBasePageState();
}

class _HqBasePageState extends State<HqBasePage> {
  List<String> titles = ['123', '123', '12321'];
  @override
  void initState() {
    for (var i = 0; i < 20; i++) {
      titles.add(i.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Base Widget'),
      ),
      body: Align(
          child: Container(
        color: Colors.blue,
        child: HqSegmentView(initSelctedIndex: 1, itemTitles: titles),
      )),
    );
  }
}

class HqSegmentView extends StatefulWidget {
  final int initSelctedIndex;
  final List<String> itemTitles;
  final double? btnWidth;
  const HqSegmentView(
      {required this.initSelctedIndex,
      required this.itemTitles,
      this.btnWidth,
      super.key});

  @override
  State<HqSegmentView> createState() => _HqSegmentViewState();
}

class _HqSegmentViewState extends State<HqSegmentView> {
  late int _selecedIndex = 0;
  @override
  void initState() {
    _selecedIndex = widget.initSelctedIndex;
    super.initState();
  }

  Widget button(int btnIndex, String title) {
    return Button(
      key: ValueKey('button_$btnIndex'),
      isSelected: btnIndex == _selecedIndex,
      btnIndex: btnIndex,
      title: title,
      onPressed: () {
        setState(() {
          _selecedIndex = btnIndex;
        });
      },
    );
  }

  SingleChildScrollView _buildScrollView() {
    // print('widget.itemTitles:${widget.itemTitles}');
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 30,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < widget.itemTitles.length; i++)
                      Container(
                        width: widget.btnWidth,
                        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                        child: button(i + 1, widget.itemTitles[i]),
                      ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                margin: const EdgeInsets.only(left: 10.0, right: 4.0),
                child: Row( 
                  children: [Text('123')],
                ),
              ),
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return _buildScrollView();
  }
}

class Button extends StatelessWidget {
  final bool isSelected;
  final int btnIndex;
  final VoidCallback onPressed;
  final String? title;

  const Button({
    super.key,
    required this.isSelected,
    required this.btnIndex,
    required this.onPressed,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: isSelected ? Colors.grey : Colors.grey[800],
      ),
      child: Text(this.title ?? btnIndex.toString()),
      onPressed: () {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
          alignment: 0.5,
        );
        onPressed();
      },
    );
  }
}
//////////////////////////////////////////////////
