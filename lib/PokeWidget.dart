import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PokeWidget extends StatefulWidget {

  final String name;
  final String spriteUrl;
  final int number;

  PokeWidget({
    @required this.name,
    @required this.number,
    @required this.spriteUrl
  });

  @override
  _PokeWidgetState createState() => _PokeWidgetState();
}

class _PokeWidgetState extends State<PokeWidget> {
  bool captured = false;

  void changeCaptureState() {
    setState(() {
      captured = !captured;
    });
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: changeCaptureState,
      child: Center(
        child: Card(
          color: this.captured ? Colors.yellow : Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('${widget.name}'),
              Image.asset(widget.spriteUrl),
              Text('# ${widget.number}'),
            ],
          ),
        ),
      ),
    );
  }
}
