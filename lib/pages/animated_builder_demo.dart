import 'dart:math';

import 'package:anim_demo/widgets/my_scaffold.dart';
import 'package:flutter/cupertino.dart';

///
/// [TweenAnimationBuilder] 与 [AnimatedBuilder] 很类似
/// TweenAnimationBuilder虽比AnimatedBuilder用法简单，但没有[AnimationController]无法控制动画执行的时机和重复次数
/// 另外AnimatedBuilder更适合复杂动画组合，其他动画组件都需要嵌套组合
///
class AnimatedBuilderDemo extends StatefulWidget {
  @override
  _AnimationControllerDemoState createState() =>
      _AnimationControllerDemoState();
}

///
/// 如果同时有多个AnimationController，且其时长不同，则使用[TickerProviderStateMixin]
/// 单个动画控制器使用[SingleTickerProviderStateMixin]
///
class _AnimationControllerDemoState extends State<AnimatedBuilderDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  final _size = Tween(begin: 100.0, end: 200.0);
  final _scale = Tween(begin: 1.0, end: 0.5);
  final _rotate = Tween(begin: 0.0, end: pi);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );

    _controller.addListener(() {
      //forward 执行结束状态为 Completed
      if (_controller.isCompleted) {
        _controller.reverse();
      }
      //reverse 执行结束状态为 Dismissed
      if (_controller.isDismissed) {
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'AnimationControllerDemo',
      child: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (BuildContext context, Widget child) => Container(
            color: CupertinoColors.activeBlue,
            width: _size.evaluate(_controller),
            height: _size.evaluate(_controller),
            transformAlignment: Alignment.center,
            transform: Matrix4.diagonal3Values(
              _scale.evaluate(_controller),
              _scale.evaluate(_controller),
              1.0,
            ),
            child: Icon(
              CupertinoIcons.heart_fill,
              size: _size.evaluate(_controller) / 2.0,
              color: CupertinoColors.systemRed,
            ),        
          ),
        ),
      ),
    );
  }

  Widget tweenBuilder() {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 500),
      tween: Tween(begin: 100.0, end: 200.0),
      builder: (context, value, child) {
        //value的值，实际计算方法就是上面AnimatedBuilder用法中_size.evaluate(_controller)
        return Container(
          color: CupertinoColors.activeBlue,
          width: value,
          height: value,
        );
      },
    );
  }
}
