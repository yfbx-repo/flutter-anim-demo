import 'package:flutter/cupertino.dart';


extension PageRouteExt on BuildContext {
  Future push(Widget page) => Navigator.of(this).push(
        CupertinoPageRoute(builder: (context) => page),
      );

  Future pushReplacement(Widget page) => Navigator.of(this).pushReplacement(
        CupertinoPageRoute(builder: (context) => page),
      );

  Future pushAndClear(Widget page) => Navigator.of(this).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (context) => page),
        (route) => false,
      );
}
