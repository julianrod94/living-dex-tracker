import 'package:flutter/material.dart';
import '../model/Enums/PokedexType.dart';
import '../model/Enums/ShinySelect.dart';


class AddLivingdex extends StatefulWidget {
  @override
  AddLivingdexState createState() {
    return AddLivingdexState();
  }
}

class AddLivingdexState extends State<AddLivingdex> {
  final formKey = GlobalKey<FormState>();
  Map<String, dynamic> _data = { 'shiny': false };
  var gameValues = ["Red", "Blue", "Yellow"];

  void submit() {
    if (this.formKey.currentState.validate()) {
      formKey.currentState.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Livingdex Name'
            ),
            validator: (value) => value.isEmpty ? 'Enter some text' : null,
            onSaved: (String value) {
              this._data["name"] = value;
            },
          ),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
                labelText: 'Livingdex Game'
            ),
            value: gameValues[0],
            items: gameValues.map((label) =>
                DropdownMenuItem(child: Text(label), value: label,)).toList(),
            onChanged: (value) => setState(() => _data["game"] = value),
          ),
          CheckboxListTile(
            title: const Text('Shiny'),
            value: _data["shiny"],
            onChanged: (bool value) {
              setState(() {
                _data["shiny"] = value;
              });
            },
          ),
        ],
      ),
    );
  }
}