import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/LivingdexWidget.dart';

class LivingdexScreen extends StatefulWidget {
  final int livingDexId;
  final String livingdexName;

  LivingdexScreen(
      {Key key, @required this.livingDexId, @required this.livingdexName})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => LivingdexScreenState();
}

class LivingdexScreenState extends State<LivingdexScreen> {
  bool isSearchEnabled = false;
  String searchCriteria = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.livingdexName),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () =>
                  this.setState(() =>
                  this.isSearchEnabled = !this.isSearchEnabled),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: renderScreenElements(isSearchEnabled),
        )
    );
  }


  List<Widget> renderScreenElements(bool isSearchEnabled) {
    var widgetList = List<Widget>();
    final searchBar = Padding(
        padding: EdgeInsets.all(5),
        child: TextField(
          autofocus: true,
          decoration: InputDecoration(
              hintText: 'Enter a search term'
          ),
          onChanged: (String value) {
            this.setState(() => searchCriteria = value);
          },
        ));
    final livingdex = Expanded(
        child: LivingdexWidget(widget.livingDexId, searchCriteria));

    if (isSearchEnabled) widgetList.add(searchBar);
    widgetList.add(livingdex);
    return widgetList;
  }
}