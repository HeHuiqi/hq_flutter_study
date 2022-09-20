import 'package:flutter/material.dart';

class HqCustomPasswodInputPage extends StatefulWidget {
  const HqCustomPasswodInputPage({super.key});

  @override
  State<HqCustomPasswodInputPage> createState() =>
      _HqCustomPasswodInputPageState();
}

class HqPasswordDotWidget extends StatelessWidget {
  final double dotWidth;
  final bool isSelected;
  final Color? dotNormalColor;
  final Color? dotSelectedColor;
  final Widget? normalChild;
  final Widget? selectedChild;
  HqPasswordDotWidget(
      {super.key,
      required this.dotWidth,
      required this.isSelected,
      this.dotNormalColor = const Color.fromARGB(137, 136, 108, 108),
      this.dotSelectedColor = Colors.black,
      this.normalChild,
      this.selectedChild,

      }
      );
  
  @override
  Widget build(BuildContext context) {
    if(this.normalChild != null && this.selectedChild != null){
      return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(this.dotWidth / 2.0)),
      child: Container(
        // color: isSelected ? dotSelectedColor : dotNormalColor,
        width: this.dotWidth,
        height: this.dotWidth,
        child: isSelected ? this.selectedChild:this.normalChild,
      ),
    );
    }
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(this.dotWidth / 2.0)),
      child: Container(
        color: isSelected ? dotSelectedColor : dotNormalColor,
        width: this.dotWidth,
        height: this.dotWidth,
      ),
    );
  }
}

class HqPasswordInputWidget extends StatefulWidget {
  final FocusNode focusNode;
  final double dotWidth;
  final int maxLength;
  final Color? bgColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final ValueChanged<String>? inputChanged;
  final bool isShowBorder;
  final double borderWidth;
  final Color borderColor;
  final Widget? normalDotChild;
  final Widget? selectedDotChild;
  HqPasswordInputWidget(
      {required this.focusNode,
      this.maxLength = 6,
      this.dotWidth = 16,
      this.bgColor = Colors.white,
      this.inputChanged,
      this.height = 45,
      this.width,
      this.padding,
      this.isShowBorder = false,
      this.borderWidth = 1,
      this.borderColor = const Color.fromARGB(255, 56, 54, 54),
      this.normalDotChild,
      this.selectedDotChild,
      super.key});

  @override
  State<HqPasswordInputWidget> createState() => _HqPasswordInputWidgetState();
}

class _HqPasswordInputWidgetState extends State<HqPasswordInputWidget> {
  String _inputText = '';
  List<HqPasswordDotWidget> _createDots(String inputText) {
    List<HqPasswordDotWidget> dots = [];
    for (var i = 0; i < widget.maxLength; i++) {
      HqPasswordDotWidget dot = HqPasswordDotWidget(
          isSelected: _inputText.length >= i + 1, 
          dotWidth: widget.dotWidth,
          normalChild: widget.normalDotChild,
          selectedChild: widget.selectedDotChild,);
      dots.add(dot);
    }
    return dots;
  }

  List<Container> _createSpaceLine(double width) {
    List<Container> lines = [];
    for (var i = 0; i < widget.maxLength - 1; i++) {
      Container ct =
          Container(color: widget.borderColor, height: widget.height, width: width);
      lines.add(ct);
    }

    return lines;
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      child:GestureDetector(
        onTap: () {
              FocusScope.of(context).requestFocus(widget.focusNode);
        },
        child:  Stack(alignment: AlignmentDirectional.bottomEnd, children: [
        Container(
          color: widget.bgColor,
          // color: Colors.red,
          height: widget.height,
          child: TextField(
            autofocus: true,
            //不显示光标
            showCursor: false,
            // scrollPadding: EdgeInsets.zero,
            //禁止长按选择
            enableInteractiveSelection: false,
            style: TextStyle(color: widget.bgColor),
            onSubmitted: widget.inputChanged,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              // border: OutlineInputBorder(),
              border: InputBorder.none,
              counter: Text(''),
            ),
            maxLength: widget.maxLength,
            focusNode: widget.focusNode,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _inputText = value;
              });
              if (widget.inputChanged != null) {
                widget.inputChanged!(value);
              }
            },
          ),
        ),
        Container(
            height: widget.height,
            decoration: widget.isShowBorder ? BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: widget.borderWidth, color: widget.borderColor),
            ):BoxDecoration(),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _createDots(_inputText),
              )),
        widget.isShowBorder ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _createSpaceLine(widget.borderWidth),
        ):Text(''),
        // LayoutBuilder(builder: ((context, boxConstraints) {
        //   debugPrint("boxConstraints:$boxConstraints");
        //   double itemWidth = boxConstraints.maxWidth / (widget.maxLength - 1);
        //   debugPrint("itemWidth:$itemWidth");
        //   double lineWidth = 1;
        //   return Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: _createSpaceLine(lineWidth),
        //   );
        // })),
      ]),
    ));
  }
}

class _HqCustomPasswodInputPageState extends State<HqCustomPasswodInputPage> {
  FocusNode _inputFocusNode = FocusNode();
  int _maxLength = 6;
  @override
  void dispose() {
    _inputFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Input'),
      ),
      body: Center(
          child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          padding: EdgeInsets.only(top: 500),
          children: [
            SizedBox(
              height: 30,
            ),
            HqPasswordInputWidget(
              focusNode: _inputFocusNode,
              padding: EdgeInsets.symmetric(horizontal: 60),
              maxLength: _maxLength,
              // height: 30,
              isShowBorder: true,
              borderWidth: 1,
              // selectedDotChild: Icon(Icons.ac_unit,size: 16,),
              // normalDotChild: Icon(Icons.face,size: 16,),
              // bgColor: Colors.yellow,
              inputChanged: (value) {
                debugPrint('password:$value');
                if (value.length >= _maxLength) {
                  // FocusScope.of(context).requestFocus(FocusNode());
                }
              },
            ),
            ElevatedButton(
                onPressed: (() {
                  FocusScope.of(context).requestFocus(_inputFocusNode);
                }),
                child: Text('开始输入')),
            ElevatedButton(
                onPressed: (() {
                  FocusScope.of(context).requestFocus(FocusNode());
                }),
                child: Text('Done')),
          ],
        ),
      )),
    );
  }
}
