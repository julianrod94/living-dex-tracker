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
        appBar: !isSearchEnabled
            ? AppBar(
                title: Text(widget.livingdexName),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () => this.setState(
                        () => this.isSearchEnabled = !this.isSearchEnabled),
                  ),
                ],
              )
            : AppBar(
                automaticallyImplyLeading: false,
                actions: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints.expand(
                        width: MediaQuery.of(context).size.width),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () => this.setState(() {
                              this.isSearchEnabled = !this.isSearchEnabled;
                              this.searchCriteria = '';
                            }),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextField(
                              style: TextStyle(color: Colors.white),
                              autofocus: true,
                              decoration: InputDecoration(
                                hintText: 'Enter a search term',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onChanged: (String value) {
                                this.setState(() => searchCriteria = value);
                              },
                            ),
                          ),
                          flex: 6,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                child: LivingdexWidget(widget.livingDexId, searchCriteria)),
          ],
        ));
  }
}
