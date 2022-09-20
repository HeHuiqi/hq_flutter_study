import 'package:flutter/material.dart';

class HqStateManagePage extends StatefulWidget {
  const HqStateManagePage({super.key});

  @override
  State<HqStateManagePage> createState() => _HqStateManagePageState();
}

class _HqStateManagePageState extends State<HqStateManagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('State Manage')),
        body: Center(
          child: ListView(
            children: [
              Text('Widget 自己管理状态'),
              HqTapBoxA(),
              Divider(
                height: 20,
                color: Colors.blue,
              ),
              Text('父Widget管理状态来影响子Widget'),
              HqParentWidgetBox(),
            ],
          ),
        ));
  }
}

class HqParentWidgetBox extends StatefulWidget {
  const HqParentWidgetBox({super.key});

  @override
  State<HqParentWidgetBox> createState() => _HqParentWidgetBoxState();
}

class HqTapBoxA extends StatefulWidget {
  const HqTapBoxA({super.key});

  @override
  State<HqTapBoxA> createState() => _HqTapBoxAState();
}

class _HqTapBoxAState extends State<HqTapBoxA> {
  //Widget本身来管理自己的状态
  bool _active = true;
  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: _active ? Colors.lightGreen : Colors.grey,
        ),
        child: Center(
          child: Text(
            _active ? 'Active' : 'Inactive',
            style: const TextStyle(
              fontSize: 32.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _HqParentWidgetBoxState extends State<HqParentWidgetBox> {
  //通过父Widget来管理状态，以此来影响子Widget
  bool _active = false;
  void _handleTapBoxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: HqTapBoxB(
        active: _active,
        onChanged: _handleTapBoxChanged,
      ),
    );
  }
}

class HqTapBoxB extends StatelessWidget {
  const HqTapBoxB({required this.active, required this.onChanged, super.key});
  final bool active;
  final ValueChanged<bool> onChanged;

  void _handleTap() {
    onChanged(!active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: active ? Colors.lightGreen : Colors.grey,
        ),
        child: Center(
          child: Text(
            active ? 'Active' : 'Inactive',
            style: const TextStyle(
              fontSize: 32.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
