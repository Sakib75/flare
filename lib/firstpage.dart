import 'package:complexui3/secodnPage.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final double maxSlide = 325;
  AnimationController _controller;
  bool _canBeDragged = false;
  double minDragStartEdge = 30;
  double maxDragStartEdge = 325.0 - 16.0;
  String teddy = 'idle';



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1000));

  }


  @override
  Widget build(BuildContext context) {
    var drawer1 = Container(color: Colors.blueAccent,child: Center(
      child: RaisedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => Second()
            ));
          },
          child: Text('2',style: TextStyle(fontSize: 200,color: Colors.black),)),
    ),);
    var drawer2 = Container(color: Colors.yellow,
    child: Center(
      child: Second()
    ),
    );
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onHorizontalDragStart: _onDragStart,
          onHorizontalDragUpdate: _onDragUpdate,
          onHorizontalDragEnd: _onDragEnd,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              double slide = maxSlide * _controller.value;
              double scale = 1 - (_controller.value * 0.3);
              return Stack(
                children: [
                  Transform.translate(
                      offset: Offset(maxSlide * (_controller.value -1 ) - 67,0),
                      child: Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                          ..rotateY(pi/2 * (1 - _controller.value)),
                          alignment: Alignment.centerRight,
                          child: drawer1)),
                  Transform.translate(
                    offset: Offset(slide,0),
                    child: Transform(
                        transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(-pi/2.2 * _controller.value),
                        alignment: Alignment.centerLeft,
                        child: drawer2),
                  ),
                ],

              );
            },


          ),
        ),
      ),
    );

  }
  void close() => _controller.reverse();

  void open() => _controller.forward();
  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = _controller.isDismissed &&
        details.globalPosition.dx < minDragStartEdge;
    bool isDragCloseFromRight = _controller.isCompleted &&
        details.globalPosition.dx > maxDragStartEdge;

    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta / maxSlide;
      _controller.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    //I have no idea what it means, copied from Drawer
    double _kMinFlingVelocity = 365.0;

    if (_controller.isDismissed || _controller.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      _controller.fling(velocity: visualVelocity);
    } else if (_controller.value < 0.5) {
      close();
    } else {
      open();
    }
  }
}



