import 'package:flutter/material.dart';

class AddLivingdex extends StatefulWidget {
  @override
  AddLivingdexState createState() {
    return AddLivingdexState();
  }
}

class AddLivingdexState extends State<AddLivingdex> {
  final formKey = GlobalKey<FormState>();
  Map<String, dynamic> _data = { 'shiny': false, 'game': gameValues[0] };
  static const gameValues = ["Red", "Blue", "Yellow"];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 100,
            child: Center(
              child: TextFormField(
                //initialValue: null,
                decoration: InputDecoration(
                    labelText: 'Livingdex Name'
                ),
                validator: (value) => value.isEmpty ? 'Enter some text' : null,
                onSaved: (String value) {
                  this._data["name"] = value;
                },
              ),
            ),
          ),
          Container(
            height: 100,
            child: Center(
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                    labelText: 'Livingdex Game'
                ),
                value:  _data["game"],
                items: gameValues.map((label) =>
                    DropdownMenuItem(child: Text(label), value: label,)).toList(),
                onChanged: (value) => setState(() => _data["game"] = value),
              ),
            ),
          ),
          Container(
            height: 100,
            child: Center(
              child: Row(
                children: <Widget>[
                  Text(
                    "Shiny",
                    textAlign: TextAlign.left,
                    style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.2),
                  ),
                  Checkbox(
                    value: _data["shiny"],
                    onChanged: (bool value) {
                      setState(() {
                        _data["shiny"] = value;
                      });
                    },
                  ),
                ],
                ),
            ),
          ),
          Container(
            //width: screenSize.width,
            child: new RaisedButton(
              child: new Text(
                "Let's Go!",
                style: new TextStyle(
                    color: Colors.white
                ),
              ),
              onPressed: () {
                if (formKey.currentState.validate()) {
                  formKey.currentState.save();
                  Navigator.pop(context);
                }
              },
              color: Colors.blue,
            ),
            margin: new EdgeInsets.only(
                top: 20.0
            ),
          )
        ],
      ),
    );
  }
}