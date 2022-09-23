import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HqBottomDrawerPage extends StatefulWidget {
  const HqBottomDrawerPage({super.key});

  @override
  State<HqBottomDrawerPage> createState() => _HqBottomDrawerPageState();
}

class _HqBottomDrawerPageState extends State<HqBottomDrawerPage> {
  double drawerInitH = 160;
  double drawerTopMinPadding = 80;
  double bottomPadding = 0;
  double showBodyHeight(MediaQueryData mediaQueryData, double drawerInitH) {
    final viewInsets = window.padding;
    final screenH = mediaQueryData.size.height;
    return (screenH - viewInsets.top - 36) - viewInsets.bottom - drawerInitH;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    double bodyHeight = showBodyHeight(mediaQueryData, drawerInitH);
    return Scaffold(
        appBar: AppBar(
          title: Text('GestureDetector'),
        ),
        body: Center(
            child: Column(
          children: [
            Stack(
              children: [
                Container(
                    padding: EdgeInsets.only(bottom: bottomPadding),
                    height: bodyHeight,
                    child: ListView.builder(
                        itemCount: 30,
                        itemBuilder: ((context, index) {
                          return Column(children: [
                            ListTile(
                              onTap: () {},
                              title: Text(index.toString()),
                              leading: CircleAvatar(
                                child: Text(index.toString()),
                              ),
                            ),
                            Divider(
                              height: 1,
                            )
                          ]);
                        }))),
                HqBottomDrawer(
                  drawerMinHeight: drawerInitH,
                  topMinPadding: drawerTopMinPadding,
                  mediaQueryData: mediaQueryData,
                  onDrawerHeightUpdate: (value) {
                    setState(() {
                      bottomPadding = value - drawerInitH;
                    });
                  },
                ),
              ],
            )
          ],
        )));
  }
}

/// HqBottomDrawer
///
/// [drawerTopHeadeHeight] must be <= [drawerMinHeight]
///
class HqBottomDrawer extends StatefulWidget {
  /// The drawer init height
  final double drawerMinHeight;

  /// The drawer init top padding
  final double topMinPadding;

  /// The draw top header height
  final double drawerTopHeadeHeight;
  final MediaQueryData? mediaQueryData;
  final ValueChanged<double>? onDrawerPddingUpdate;
  final ValueChanged<double>? onDrawerHeightUpdate;
  HqBottomDrawer({
    super.key,
    this.drawerMinHeight = 50,
    this.topMinPadding = 50,
    this.drawerTopHeadeHeight = 50,
    this.mediaQueryData,
    this.onDrawerHeightUpdate,
    this.onDrawerPddingUpdate,
  });

  @override
  State<HqBottomDrawer> createState() => _HqBottomDrawerState();
}

class _HqBottomDrawerState extends State<HqBottomDrawer>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  late ScrollPhysics physics;

  /// The drawer's init content height is widget's [HqBottomDrawer.drawerMinHeight], it is will change when user scroll the drawer
  double _contentH = 0;
  double _topPadding = 0;
  double _maxTopPadding = 0;
  double _maxContentHeight = 0;
  late Animation<double> paddingAnimation;
  late Animation<double> heightAnimation;
  late AnimationController animationController;

  double getShowBodyHeight() {
    Size screenSize = window.physicalSize;
    WindowPadding viewInsets = window.padding;
    if (widget.mediaQueryData != null) {
      screenSize = widget.mediaQueryData!.size;
      return (screenSize.height - viewInsets.top - 36) - viewInsets.bottom;
    }
    return (screenSize.height / 2.0 - viewInsets.top - 36) - viewInsets.bottom;
  }

  @override
  void initState() {
    physics = NeverScrollableScrollPhysics();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 100), vsync: this);
    _contentH = widget.drawerMinHeight;
    double bodyHeight = getShowBodyHeight();
    _maxContentHeight = bodyHeight - widget.topMinPadding;
    _maxTopPadding = bodyHeight - widget.drawerMinHeight;

    _topPadding = _maxTopPadding;

    scrollController.addListener(() {
      // if (scrollController.offset <= 0) {
      //   setState(() {
      //     scrollController.animateTo(0, duration: Duration(seconds: 0), curve: Curves.easeIn);
      //     scrollController.jumpTo(0);
      //     physics = NeverScrollableScrollPhysics();
      //   });
      // }
    });
    super.initState();
  }

  void animateDrawer() {
    double bodyHeight = getShowBodyHeight();
    bool isTop = _contentH > (bodyHeight / 2.0) ? true : false;
    final CurvedAnimation curve =
        new CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    paddingAnimation = Tween<double>(
            begin: _contentH,
            end: isTop ? _maxContentHeight : widget.drawerMinHeight)
        .animate(curve)
      ..addListener(() {
        setState(() {
          _contentH = paddingAnimation.value;
          if (widget.onDrawerHeightUpdate != null) {
            widget.onDrawerHeightUpdate!(_contentH);
          }
        });
      });
    heightAnimation = Tween<double>(
            begin: _topPadding,
            end: isTop ? widget.topMinPadding : _maxTopPadding)
        .animate(curve)
      ..addListener(() {
        setState(() {
          _topPadding = heightAnimation.value;

          if (widget.onDrawerPddingUpdate != null) {
            widget.onDrawerPddingUpdate!(_topPadding);
          }
        });
      });
    animationController.reset();
    animationController.forward();
  }

  @override
  void dispose() {
    scrollController.dispose();
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: _topPadding),
      child: GestureDetector(
        child: Container(
            // color: Colors.white,
            height: _contentH,
            child: Column(
              children: [
                Container(
                  color: Colors.deepPurple,
                  padding: EdgeInsets.only(top: 5),
                  child: Container(
                      // color: Colors.blue,
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            width: 48,
                            height: 6,
                            color: Colors.white,
                          )),
                      Divider(
                        height: 1.0,
                      ),
                    ],
                  )),
                  height: widget.drawerTopHeadeHeight > widget.drawerMinHeight
                      ? widget.drawerMinHeight
                      : widget.drawerTopHeadeHeight,
                ),
                Expanded(
                    child: ListView.builder(
                        controller: scrollController,
                        physics: physics,
                        itemCount: 30,
                        itemBuilder: ((context, index) {
                          return Column(
                            children: [
                              ListTile(
                                title: Text(index.toString()),
                                leading: CircleAvatar(
                                  child: Text((index + 1).toString()),
                                ),
                                onTap: () {
                                  print('drawer list item click:$index');
                                },
                              ),
                              Divider(
                                height: 1.0,
                              ),
                            ],
                          );
                        }))),
              ],
            )),
        onVerticalDragCancel: () {},
        onVerticalDragStart: (details) {
          // print('onVerticalDragStart-globalPosition:${details.globalPosition}');
          // print('onVerticalDragStart-localPosition:${details.localPosition}');
        },
        onVerticalDragUpdate: (details) {
          // print('onVerticalDragUpdate-globalPosition:${details.globalPosition}');
          // print('onVerticalDragUpdate-localPosition:${details.localPosition}');
          // print('onVerticalDragUpdate-localPosition:${details.delta}');
          setState(() {
            _contentH -= details.delta.dy;
            if (_contentH >= _maxContentHeight) {
              _contentH = _maxContentHeight;
            }
            if (_contentH <= widget.drawerMinHeight) {
              _contentH = widget.drawerMinHeight;
            }

            _topPadding += details.delta.dy;

            if (_topPadding <= widget.topMinPadding) {
              _topPadding = widget.topMinPadding;
            }
            if (_topPadding >= _maxTopPadding) {
              _topPadding = _maxTopPadding;
            }
            if (widget.onDrawerHeightUpdate != null) {
              widget.onDrawerHeightUpdate!(_contentH);
            }
            if (widget.onDrawerPddingUpdate != null) {
              widget.onDrawerPddingUpdate!(_topPadding);
            }
          });
        },
        onVerticalDragEnd: (details) {
          // print('onVerticalDragEnd-primaryVelocity:${details.primaryVelocity}');
          // print('onVerticalDragEnd-velocity:${details.velocity}');
          setState(() {
            if (_contentH >= _maxContentHeight) {
              physics = AlwaysScrollableScrollPhysics();
            } else {
              // scrollController.animateTo(0, duration: Duration(milliseconds: 100), curve: Curves.easeIn);
              scrollController.jumpTo(0);
              physics = NeverScrollableScrollPhysics();
            }
          });
          animateDrawer();
        },
      ),
    );
  }
}

class HqRawGestureDetector extends StatefulWidget {
  const HqRawGestureDetector({super.key});

  @override
  State<HqRawGestureDetector> createState() => _HqRawGestureDetectorState();
}

class _HqRawGestureDetectorState extends State<HqRawGestureDetector> {
  String _last = 'init';
  @override
  Widget build(BuildContext context) {
    return Container(
        child: RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        TapGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
          () {
            return TapGestureRecognizer();
          },
          (TapGestureRecognizer instance) {
            instance.onTapDown = (TapDownDetails details) {
              print('down');
              setState(() {
                _last = 'down';
              });
            };
            instance.onTapUp = (TapUpDetails details) {
              print('up');
              setState(() {
                _last = 'up';
              });
            };
            instance.onTap = () {
              print('tap');
              setState(() {
                _last = 'tap';
              });
            };
            instance.onTapCancel = () {
              print('cancel');
              setState(() {
                _last = 'cancel';
              });
            };
          },
        ),
      },
      child: Container(
          width: 200.0,
          height: 200.0,
          color: Colors.yellow,
          child: Text(
            _last,
            textAlign: TextAlign.center,
          )),
    ));
  }
}
