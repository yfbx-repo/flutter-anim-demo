import 'dart:math';

import 'package:anim_demo/widgets/my_scaffold.dart';
import 'package:flutter/cupertino.dart';

///
/// [AnimatedContainer]需要setState改变属性值实现动画
/// 若setState会导致其父组件重建的话，对动画效果有影响
///
class AnimatedContainerDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<AnimatedContainerDemo> {
  double _size = 200;
  double _angle = 0.0;
  double _scale = 1.0;
  Alignment _alignment = Alignment.centerLeft;

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'AnimatedContainer Demo',
      child: Center(
        child: GestureDetector(
          onTap: onPress,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            //transform属性，子Widget会随之改变
            //transform: Matrix4.rotationZ(_angle),
            transform: Matrix4.diagonal3Values(_scale, _scale, 1.0),
            transformAlignment: Alignment.center,
            alignment: Alignment.center,
            color: CupertinoColors.activeBlue,
            //宽高属性不会对子Widget起作用，即宽高变化，子Widget的大小不会变化.
            width: _size,
            height: _size,
            onEnd: onPress,
            //将子Widget宽高与_size关联(如设为_size/2),子Widget大小会因为setState而改变，但子Widget没有动画过程
            child: Container(
              width: 100,
              height: 100,
              color: CupertinoColors.white,
              alignment: Alignment.center,
              child: Text('Animation'),
            ),
          ),
        ),
      ),
    );
  }

  ///
  ///
  ///
  void onPress() {
    setState(() {
      _size = _size == 200 ? 400 : 200;
      _scale = _scale == 1.0 ? 0.5 : 1.0;
      _alignment = _alignment == Alignment.centerLeft
          ? Alignment.centerRight
          : Alignment.centerLeft;

      ///最大只会旋转180度, 180-360会逆向旋转,超过360会进行取余操作，再次从0开始
      ///例如旋转270度,会逆时针旋转90度；旋转450度，会顺时针旋转90度
      _angle = _angle == 0 ? pi : 0;
    });
  }
}
