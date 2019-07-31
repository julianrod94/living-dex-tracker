import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/Livingdex.dart';

class LivingdexScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grid View"),
      ),
      body: Center(
        child: Livingdex(),
      ),
    );
  }
}