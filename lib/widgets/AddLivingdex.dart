import 'package:flutter/material.dart';
import '../model/Enums/PokedexType.dart';
import '../model/Enums/ShinySelect.dart';


class AddLivingdex extends StatefulWidget{
  @override
  AddLivingdexState createState(){
    return AddLivingdexState();
  }
}

class _LivingdexData{
  String name = '';
  String game = '';
  PokedexType  regional = PokedexType.REGIONAL;
  ShinySelect shiny = ShinySelect.NORMAL;
}

class AddLivingdexState extends State<AddLivingdex>{
  final formKey = GlobalKey<FormState>();
  _LivingdexData _data = new _LivingdexData();
  PokedexType _regnat = PokedexType.REGIONAL;

  void submit(){
    if(this.formKey.currentState.validate()){
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
            decoration: new InputDecoration(
              labelText: 'Livingdex Name'
            ),
            validator:(value){
              if(value.isEmpty){
                return 'Enter some text';
              }
              return null;
            },
            onSaved: (String value){
              this._data.name = value;
            },
          )
          DropdownButtonFormField<String>(
            value: selected,
            decoration: new InputDecoration(
              labelText: 'Livingdex Game'
            ),
            items: ["Red","Blue","Yellow"],
            onChanged: (value){
              setState(() => _data.game = value );
            },
          ),
          RadioListTile<PokedexType>(
            title: const Text('National'),
            value: PokedexType.NATIONAL,
            groupValue: _regnat,
            onChanged: (PokedexType value) { setState(() { _regnat = value; }); },
          ),
          RadioListTile<PokedexType>(
          title: const Text('Regional'),
          value: PokedexType.REGIONAL,
          groupValue: _regnat,
          onChanged: (PokedexType value) { setState(() { _regnat = value; }); },
          ),
        ],
      ),
    );
  }
}