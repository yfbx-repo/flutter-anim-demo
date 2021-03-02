# Flutter 动画


## AnimatedContainer
通过`setState`改变属性值实现动画，`transform`属性可影响其子组件。    


系统提供了一系列的动画组件：    
`AnimatedPadding`    
`AnimatedAlign`    
`AnimatedPositioned`    
`AnimatedOpacity`    
`AnimatedDefaultTextStyle`    
...

```
  double _size = 200;
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
   return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _size = 400;
            _scale = 0.5;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          width: _size,//子组件的大小不会随之改变
          height: _size,
          transform: Matrix4.diagonal3Values(_scale, _scale, 1.0),//子组件会随之改变
          transformAlignment: Alignment.center,
        ),
      ),
    );
  }
```


## AnimationController + Animation

动画状态：   
  **`forward` 执行结束状态为 `Completed`**    
  **`reverse` 执行结束状态为 `Dismissed`**    
      
如果同时有多个AnimationController，且其时长不同，则使用`TickerProviderStateMixin`，单个动画控制器使用`SingleTickerProviderStateMixin`。    

```
class DemoState extends State<Demo> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );

    _scaleAnimation = Tween(begin: 1.0, end: 0.5).animate(_controller);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        color: CupertinoColors.activeBlue,
        width: 100,
        height: 100,
      ),
    );
  }
}

```

例子中使用了`ScaleTransition`去实现动画，也有直接使用`animation.value`去改变属性值的用法，需要监听`controller`变化，然后`setState`。 
```
class DemoState extends State<Demo> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );

    _animation = Tween(begin: 1.0, end: 0.5).animate(_controller);

    _controller.addListener(() {
      setState(){}
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.activeBlue,
      width: 100 * _animation.value,
      height: 100 * _animation.value,
    );
  }
}
```   

不推荐这种用法，简单动画直接使用系统提供的一系列Transition就可以了：    

 `ScaleTransition`    
 `SlideTransition`    
 `RotationTransition`    
 `FadeTransition`    
 `SizeTransition`    
 `PositionedTransition`    
 `RelativePositionedTransition`    
 `DecoratedBoxTransition`    
 `AlignTransition`    
 `DefaultTextStyleTransition`    
 ···

 若系统提供的Transition无法满足需求，可以使用`AnimatedBuilder`

 ## AnimatedBuilder + AnimationController
 推荐这种用法

```
  final _size = Tween(begin: 100.0, end: 200.0);
  final _rotate = Tween(begin: 0.0, end: pi);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
      builder: (BuildContext context, Widget child) => Container(
        width: _size.evaluate(_controller),
        height: _size.evaluate(_controller),
        transformAlignment: Alignment.center,
        transform: Matrix4.rotationZ(_rotate.evaluate(_controller)),
      ),
    );
  }

```
`_size.evaluate(_controller)` 这个就是`Tween`动画随`AnimationController`时长变化以及`curve`属性而自动计算的值。    

## TweenAnimationBuilder 

`TweenAnimationBuilder` 已将值变化计算好交给子Widget使用。   
使用简单，没有`AnimationController`,也无法控制动画的执行时机和重复次数

```
TweenAnimationBuilder(
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
```