import 'package:flutter/material.dart';
import '../widgets/CreateLivingdex.dart';

class CreateLivingdexScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add View"),
      ),
      body: Column(
          children: <Widget>[
            AddLivingdex()
          ],
      ),
    );
  }
}
