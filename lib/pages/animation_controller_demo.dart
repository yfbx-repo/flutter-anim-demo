import 'package:anim_demo/widgets/my_scaffold.dart';
import 'package:flutter/cupertino.dart';

///
/// AnimationController
/// flutter中已经有一系列的变换动画：
/// [ScaleTransition],[SlideTransition],[RotationTransition],
/// [FadeTransition],[SizeTransition],[PositionedTransition],
/// [RelativePositionedTransition],[DecoratedBoxTransition],
/// [AlignTransition],[DefaultTextStyleTransition]
/// 若无法满足需求，可使用 [AnimatedBuilder]或者[TweenAnimationBuilder]自定义动画
///
class AnimationControllerDemo extends StatefulWidget {
  @override
  _AnimationControllerDemoState createState() =>
      _AnimationControllerDemoState();
}

///
/// 如果同时有多个AnimationController，且其时长不同，则使用[TickerProviderStateMixin]
/// 单个动画控制器使用[SingleTickerProviderStateMixin]
///
class _AnimationControllerDemoState extends State<AnimationControllerDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _scaleAnimation;
  Animation _slideAnimation;
  Animation _fadeAnimation;
  Animation _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween(begin: 1.0, end: 0.0).animate(_controller);
    _scaleAnimation = Tween(begin: 1.0, end: 0.5).animate(_controller);
    _rotateAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _slideAnimation = Tween(
      begin: Offset(0.0, 0.0),
      end: Offset(1.0, 0.0),
    ).animate(_controller);

    _controller.addListener(() {
      _controller.repeat();
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'AnimationControllerDemo',
      child: Column(
        children: [
          //缩放
          ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              color: CupertinoColors.activeBlue,
              width: 100,
              height: 100,
            ),
          ),
          //移动
          SlideTransition(
            position: _slideAnimation,
            child: Container(
              color: CupertinoColors.activeBlue,
              width: 100,
              height: 100,
            ),
          ),
          //旋转
          RotationTransition(
            turns: _rotateAnimation,
            child: Container(
              color: CupertinoColors.activeBlue,
              width: 100,
              height: 100,
              child: Text('rotation'),
            ),
          ),
          //透明度变化
          FadeTransition(
            opacity: _fadeAnimation,
            alwaysIncludeSemantics: false, //???
            child: Container(
              color: CupertinoColors.activeBlue,
              width: 100,
              height: 100,
              alignment: Alignment.center,
              child: Container(
                width: 50,
                height: 50,
                color: CupertinoColors.activeOrange,
              ),
            ),
          ),
          //尺寸变化，与缩放相比，可单一方向变化
          SizeTransition(
            sizeFactor: _scaleAnimation,
            axis: Axis.vertical, //纵向
            axisAlignment: 0.5, //0.0从顶部开始变化，1.0从底部开始变化
            child: SizeTransition(
              sizeFactor: _scaleAnimation,
              axis: Axis.horizontal, //横向
              axisAlignment: 0.5, //0.0从左侧开始变化，1.0从右侧开始变化
              child: Container(
                color: CupertinoColors.activeBlue,
                width: 100,
                height: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
