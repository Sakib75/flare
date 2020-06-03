import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flare_dart/actor.dart';
class Second extends StatefulWidget {

  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  String teddy = 'idle';
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipOval(
          child: Container(
            color: Colors.white,
            height: 250,
            width: 250,
            child: FlareActor('assets/Teddy.flr',animation: teddy,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buttons('idle'),
            buttons('test'),
            buttons('success'),
            buttons('fail'),
          ],
        )
      ],
    );
  }

  RaisedButton buttons(String title) {
    return RaisedButton(
            onPressed: () {
              setState(() {
                teddy = title;
              });
            },
            child: Text(title),
          );
  }
}
