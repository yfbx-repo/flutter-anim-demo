import 'package:flutter/cupertino.dart';

///
/// 需要加NavigationBar才会自动适配状态栏字体颜色
///
class MyScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final Color navigationBarColor;
  final Color backgroundColor;
  final bool leading;

  const MyScaffold({
    Key key,
    @required this.child,
    this.navigationBarColor = CupertinoColors.white,
    this.backgroundColor = CupertinoColors.lightBackgroundGray,
    this.title = '',
    this.leading = true,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: child,
      backgroundColor: backgroundColor,
      navigationBar: CupertinoNavigationBar(
        border: Border(),
        automaticallyImplyLeading: false,
        backgroundColor: navigationBarColor,
        leading: leading
            ? GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  CupertinoIcons.back,
                  size: 20,
                  color: CupertinoColors.black.withOpacity(0.8),
                ),
              )
            : null,
        middle: Text(
          title ?? '',
          style: TextStyle(
            fontSize: 18,
            color: CupertinoColors.black.withOpacity(0.8),
          ),
        ),
      ),
    );
  }
}
