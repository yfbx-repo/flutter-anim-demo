import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pages/animated_builder_demo.dart';
import 'pages/animated_container_demo.dart';
import 'pages/animation_controller_demo.dart';
import 'utils/utils.dart';
import 'widgets/my_scaffold.dart';

void main() {
  runApp(
    CupertinoApp(
      title: 'Animation Demo',
      home: HomePage(),
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Animation Demo',
      leading: false,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            button('AnimatedContainer', AnimatedContainerDemo()),
            SizedBox(height: 10),
            button('AnimationController', AnimationControllerDemo()),
            SizedBox(height: 10),
            button('AnimatedBuilder', AnimatedBuilderDemo()),
          ],
        ),
      ),
    );
  }

  Widget button(String text, Widget page) {
    return CupertinoButton(
      child: Text(text),
      color: CupertinoColors.activeBlue,
      onPressed: () => context.push(page),
    );
  }
}
